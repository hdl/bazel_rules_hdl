// 67d7842dbbe25473c3c32b93c0da8047785f30d78e8a024de1b57352245f9689
/*
#-  (c) Copyright 2011-2019 Xilinx, Inc. All rights reserved.
#-
#-  This file contains confidential and proprietary information
#-  of Xilinx, Inc. and is protected under U.S. and
#-  international copyright and other intellectual property
#-  laws.
#-
#-  DISCLAIMER
#-  This disclaimer is not a license and does not grant any
#-  rights to the materials distributed herewith. Except as
#-  otherwise provided in a valid license issued to you by
#-  Xilinx, and to the maximum extent permitted by applicable
#-  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
#-  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
#-  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
#-  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
#-  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
#-  (2) Xilinx shall not be liable (whether in contract or tort,
#-  including negligence, or under any other theory of
#-  liability) for any loss or damage of any kind or nature
#-  related to, arising under or in connection with these
#-  materials, including for any direct, or any indirect,
#-  special, incidental, or consequential loss or damage
#-  (including loss of data, profits, goodwill, or any type of
#-  loss or damage suffered as a result of any action brought
#-  by a third party) even if such damage or loss was
#-  reasonably foreseeable or Xilinx had been advised of the
#-  possibility of the same.
#-
#-  CRITICAL APPLICATIONS
#-  Xilinx products are not designed or intended to be fail-
#-  safe, or for use in any application requiring fail-safe
#-  performance, such as life-support or safety devices or
#-  systems, Class III medical devices, nuclear facilities,
#-  applications related to the deployment of airbags, or any
#-  other applications that could lead to death, personal
#-  injury, or severe property or environmental damage
#-  (individually and collectively, "Critical
#-  Applications"). Customer assumes the sole risk and
#-  liability of any use of Xilinx products in Critical
#-  Applications, subject only to applicable laws and
#-  regulations governing limitations on product liability.
#-
#-  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
#-  PART OF THIS FILE AT ALL TIMES. 
#- ************************************************************************

*/

#ifndef AP_FIXED_SPECIAL_H
#define AP_FIXED_SPECIAL_H
#ifndef __SYNTHESIS__
#include <cstdio>
#include <cstdlib>
#endif
// FIXME AP_AUTOCC cannot handle many standard headers, so declare instead of
// include.
// #include <complex>
namespace std {
template<typename _Tp> class complex;
}

/*
  TODO: Modernize the code using C++11/C++14
  1. constexpr http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2016/p0415r0.html
  2. move constructor
*/

namespace std {
/*
   Specialize std::complex<ap_fixed> to zero initialization ap_fixed.

   To reduce the area cost, ap_fixed is not zero initialized, just like basic
   types float or double. However, libstdc++ provides specialization for float,
   double and long double, initializing image part to 0 when not specified.

   This has become a difficulty in switching legacy code from these C types to
   ap_fixed. To ease the tranform of legacy code, we have to implement
   specialization of std::complex<> for our type.

   As ap_fixed is a template, it is impossible to specialize only the methods
   that causes default initialization of value type in std::complex<>. An
   explicit full specialization of the template class has to be done, covering
   all the member functions and operators of std::complex<> as specified
   in standard 26.2.4 and 26.2.5.
*/
template <int _AP_W, int _AP_I, ap_q_mode _AP_Q, ap_o_mode _AP_O, int _AP_N>
class complex<ap_fixed<_AP_W, _AP_I, _AP_Q, _AP_O, _AP_N> > {
 public:
  typedef ap_fixed<_AP_W, _AP_I, _AP_Q, _AP_O, _AP_N> _Tp;
  typedef _Tp value_type;

  // 26.2.4/1
  // Constructor without argument
  // Default initialize, so that in dataflow, the variable is only written once.
  complex() : _M_real(_Tp()), _M_imag(_Tp()) {}
  // Constructor with ap_fixed.
  // Zero initialize image part when not specified, so that `C(1) == C(1,0)`
  complex(const _Tp &__r, const _Tp &__i = _Tp(0))
      : _M_real(__r), _M_imag(__i) {}

  // Constructor with another complex number
  template <typename _Up>
  complex(const complex<_Up> &__z) : _M_real(__z.real()), _M_imag(__z.imag()) {}

#if __cplusplus >= 201103L
  const _Tp& real() const { return _M_real; }
  const _Tp& imag() const { return _M_imag; }
#else
  _Tp& real() { return _M_real; }
  const _Tp& real() const { return _M_real; }
  _Tp& imag() { return _M_imag; }
  const _Tp& imag() const { return _M_imag; }
#endif
 
  void real(_Tp __val) { _M_real = __val; }

  void imag(_Tp __val) { _M_imag = __val; }

  // Assign this complex number with ap_fixed.
  // Zero initialize image poarrt, so that `C c; c = 1; c == C(1,0);`
  complex<_Tp> &operator=(const _Tp __t) {
    _M_real = __t;
    _M_imag = _Tp(0);
    return *this;
  }

  // 26.2.5/1
  // Add ap_fixed to this complex number.
  complex<_Tp> &operator+=(const _Tp &__t) {
    _M_real += __t;
    return *this;
  }

  // 26.2.5/3
  // Subtract ap_fixed from this complex number.
  complex<_Tp> &operator-=(const _Tp &__t) {
    _M_real -= __t;
    return *this;
  }

  // 26.2.5/5
  // Multiply this complex number by ap_fixed.
  complex<_Tp> &operator*=(const _Tp &__t) {
    _M_real *= __t;
    _M_imag *= __t;
    return *this;
  }

  // 26.2.5/7
  // Divide this complex number by ap_fixed.
  complex<_Tp> &operator/=(const _Tp &__t) {
    _M_real /= __t;
    _M_imag /= __t;
    return *this;
  }

  // Assign complex number to this complex number.
  template <typename _Up>
  complex<_Tp> &operator=(const complex<_Up> &__z) {
    _M_real = __z.real();
    _M_imag = __z.imag();
    return *this;
  }

  // 26.2.5/9
  // Add complex number to this.
  template <typename _Up>
  complex<_Tp> &operator+=(const complex<_Up> &__z) {
    _M_real += __z.real();
    _M_imag += __z.imag();
    return *this;
  }

  // 26.2.5/11
  // Subtract complex number from this.
  template <typename _Up>
  complex<_Tp> &operator-=(const complex<_Up> &__z) {
    _M_real -= __z.real();
    _M_imag -= __z.imag();
    return *this;
  }

  // 26.2.5/13
  // Multiply this by complex number.
  template <typename _Up>
  complex<_Tp> &operator*=(const complex<_Up> &__z) {
    const _Tp __r = _M_real * __z.real() - _M_imag * __z.imag();
    _M_imag = _M_real * __z.imag() + _M_imag * __z.real();
    _M_real = __r;
    return *this;
  }

  // 26.2.5/15
  // Divide this by complex number.
  template <typename _Up>
  complex<_Tp> &operator/=(const complex<_Up> &__z) {
    complex<_Tp> cj (__z.real(), -__z.imag());
    complex<_Tp> a = (*this) * cj;
    complex<_Tp> b = cj * __z;
    _M_real = a.real() / b.real();
    _M_imag = a.imag() / b.real();
    return *this;
  }

 private:
  _Tp _M_real;
  _Tp _M_imag;

}; // class complex<ap_fixed<_AP_W, _AP_I, _AP_Q, _AP_O, _AP_N> >

/*
   Non-member operations
   These operations are not required by standard in 26.2.6, but libstdc++
   defines them for
   float, double or long double's specialization.
*/
// Compare complex number with ap_fixed.
template <int _AP_W, int _AP_I, ap_q_mode _AP_Q, ap_o_mode _AP_O, int _AP_N>
inline bool operator==(
    const complex<ap_fixed<_AP_W, _AP_I, _AP_Q, _AP_O, _AP_N> > &__x,
    const ap_fixed<_AP_W, _AP_I, _AP_Q, _AP_O, _AP_N> &__y) {
  return __x.real() == __y &&
         __x.imag() == 0;
}

// Compare ap_fixed with complex number.
template <int _AP_W, int _AP_I, ap_q_mode _AP_Q, ap_o_mode _AP_O, int _AP_N>
inline bool operator==(
    const ap_fixed<_AP_W, _AP_I, _AP_Q, _AP_O, _AP_N> &__x,
    const complex<ap_fixed<_AP_W, _AP_I, _AP_Q, _AP_O, _AP_N> > &__y) {
  return __x == __y.real() &&
         0 == __y.imag();
}

// Compare complex number with ap_fixed.
template <int _AP_W, int _AP_I, ap_q_mode _AP_Q, ap_o_mode _AP_O, int _AP_N>
inline bool operator!=(
    const complex<ap_fixed<_AP_W, _AP_I, _AP_Q, _AP_O, _AP_N> > &__x,
    const ap_fixed<_AP_W, _AP_I, _AP_Q, _AP_O, _AP_N> &__y) {
  return __x.real() != __y ||
         __x.imag() != 0;
}

// Compare ap_fixed with complex number.
template <int _AP_W, int _AP_I, ap_q_mode _AP_Q, ap_o_mode _AP_O, int _AP_N>
inline bool operator!=(
    const ap_fixed<_AP_W, _AP_I, _AP_Q, _AP_O, _AP_N> &__x,
    const complex<ap_fixed<_AP_W, _AP_I, _AP_Q, _AP_O, _AP_N> > &__y) {
  return __x != __y.real() ||
         0 != __y.imag();
}

}  // namespace std

#endif  // ifndef AP_FIXED_SPECIAL_H


