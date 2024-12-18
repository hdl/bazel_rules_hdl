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
 *     (c) Copyright 2012 Xilinx Inc.
 *     All rights reserved.
 *
 *****************************************************************************/

#ifndef X_HLS_UTILS_H
#define X_HLS_UTILS_H
#include "vitis/v2021_2/ap_fixed.h"
#include "vitis/v2021_2/hls_half.h"
#include <limits>
#include <stdint.h>
#ifndef __SYNTHESIS__
#include <cmath>
#include <iostream>
#endif

/*
*******************************************************************************
* HLS utilities
* -----------------------
*
* General utilities usable by all functions. Mainly contains classes to
* generate static values from recursive class declarations.
*
* pow2
* sqrtf - C declaration
* to_float
*
* fp_struct<float>
* fp_struct<double>
* fp_struct<half>
* dumpDouble
*
* Power - B^N
* BitWidth = calculate minimum # of bits to store given integer value
*
* Table
*
*******************************************************************************
*/

namespace hls {

template <typename T> class numeric_limits {
public:
  static T max() { return std::numeric_limits<T>::max(); }
  static T min() { return std::numeric_limits<T>::min(); }
  static T epsilon() { return std::numeric_limits<T>::epsilon(); }
};

template <int W, int I, ap_q_mode Q, ap_o_mode O>
class numeric_limits<ap_fixed<W, I, Q, O>> {
public:
  static ap_fixed<W, I, Q, O> max() {
    ap_int<W> m = ::hls::numeric_limits<ap_int<W>>::max();
    ap_fixed<W, I, Q, O> x;
    x(W - 1, 0) = m(W - 1, 0);
    return x;
  }
  static ap_fixed<W, I, Q, O> min() {
    ap_int<W> m = ::hls::numeric_limits<ap_int<W>>::min();
    ap_fixed<W, I, Q, O> x;
    x(W - 1, 0) = m(W - 1, 0);
    return x;
  }
  static ap_fixed<W, I, Q, O> epsilon() {
    ap_fixed<W, I, Q, O> x = 0;
    x[0] = 1; // One of the definitions is: Machine epsilon is defined as the
              // smallest number that, when added to one, yields a result
              // different from one
    return x;
  }
};

template <int W, int I, ap_q_mode Q, ap_o_mode O>
class numeric_limits<ap_ufixed<W, I, Q, O>> {
public:
  static ap_ufixed<W, I, Q, O> max() {
    ap_uint<W> m = ::hls::numeric_limits<ap_uint<W>>::max();
    ap_ufixed<W, I, Q, O> x;
    x(W - 1, 0) = m(W - 1, 0);
    return x;
  }
  static ap_ufixed<W, I, Q, O> min() { return 0; }
  static ap_ufixed<W, I, Q, O> epsilon() {
    ap_ufixed<W, I, Q, O> x = 0;
    x[0] = 1;
    return x;
  }
};

template <int W> class numeric_limits<ap_int<W>> {
public:
  static ap_int<W> max() {
    ap_int<W> m = min();
    return ~m;
  }
  static ap_int<W> min() {
    ap_int<W> m = 0;
    m[W - 1] = 1;
    return m;
  }
  static ap_int<W> epsilon() {
    ap_int<W> x = 0;
    x[0] = 1;
    return x;
  }
};

template <int W> class numeric_limits<ap_uint<W>> {
public:
  static ap_uint<W> max() {
    ap_uint<W> zero = 0;
    return ~zero;
  }
  static ap_uint<W> min() { return 0; }
  static ap_uint<W> epsilon() {
    ap_uint<W> x = 0;
    x[0] = 1;
    return x;
  }
};
} // namespace hls

namespace hlstmp {

template <typename T> class numeric_limits {
public:
  static T max() { return std::numeric_limits<T>::max(); }
  static T min() { return std::numeric_limits<T>::min(); }
  static T epsilon() { return std::numeric_limits<T>::epsilon(); }
};

template <int W, int I, ap_q_mode Q, ap_o_mode O>
class numeric_limits<ap_fixed<W, I, Q, O>> {
public:
  static ap_fixed<W, I, Q, O> max() {
    ap_int<W> m = ::hlstmp::numeric_limits<ap_int<W>>::max();
    ap_fixed<W, I, Q, O> x;
    x(W - 1, 0) = m(W - 1, 0);
    return x;
  }
  static ap_fixed<W, I, Q, O> min() {
    ap_int<W> m = ::hlstmp::numeric_limits<ap_int<W>>::min();
    ap_fixed<W, I, Q, O> x;
    x(W - 1, 0) = m(W - 1, 0);
    return x;
  }
  static ap_fixed<W, I, Q, O> epsilon() {
    ap_fixed<W, I, Q, O> x = 0;
    x[0] = 1; // One of the definitions is: Machine epsilon is defined as the
              // smallest number that, when added to one, yields a result
              // different from one
    return x;
  }
};

template <int W, int I, ap_q_mode Q, ap_o_mode O>
class numeric_limits<ap_ufixed<W, I, Q, O>> {
public:
  static ap_ufixed<W, I, Q, O> max() {
    ap_uint<W> m = ::hlstmp::numeric_limits<ap_uint<W>>::max();
    ap_ufixed<W, I, Q, O> x;
    x(W - 1, 0) = m(W - 1, 0);
    return x;
  }
  static ap_ufixed<W, I, Q, O> min() { return 0; }
  static ap_ufixed<W, I, Q, O> epsilon() {
    ap_ufixed<W, I, Q, O> x = 0;
    x[0] = 1;
    return x;
  }
};

template <int W> class numeric_limits<ap_int<W>> {
public:
  static ap_int<W> max() {
    ap_int<W> m = min();
    return ~m;
  }
  static ap_int<W> min() {
    ap_int<W> m = 0;
    m[W - 1] = 1;
    return m;
  }
  static ap_int<W> epsilon() {
    ap_int<W> x = 0;
    x[0] = 1;
    return x;
  }
};

template <int W> class numeric_limits<ap_uint<W>> {
public:
  static ap_uint<W> max() {
    ap_uint<W> zero = 0;
    return ~zero;
  }
  static ap_uint<W> min() { return 0; }
  static ap_uint<W> epsilon() {
    ap_uint<W> x = 0;
    x[0] = 1;
    return x;
  }
};
} // namespace hlstmp

static inline const uint32_t pow2(uint32_t e) {
  switch (e) {
  case 0:
    return 1;
    break;
  case 1:
    return 2;
    break;
  case 2:
    return 4;
    break;
  case 3:
    return 8;
    break;
  case 4:
    return 16;
    break;
  case 5:
    return 32;
    break;
  case 6:
    return 64;
    break;
  case 7:
    return 128;
    break;
  case 8:
    return 256;
    break;
  case 9:
    return 512;
    break;
  case 10:
    return 1024;
    break;
  case 11:
    return 2048;
    break;
  default:
    return 0;
  }
}

template<typename T>
#ifndef _MSC_VER
__attribute__((hls_preserve))
#endif
T reg(T d)
{
#pragma HLS PIPELINE II = 1
#pragma HLS LATENCY min = 1 max = 1
#pragma HLS INLINE off
  return d;
}

/*
 *------------------------------------------------------------------------------
 * References C square root function for single precision square root.
 * Maps to FPU sqrt core
 *------------------------------------------------------------------------------
 */
// extern "C" float sqrtf(float);

/*
 *------------------------------------------------------------------------------
 * Converts data to float type
 *------------------------------------------------------------------------------
 */
static inline float to_float(float v) { return v; }

template <int _W, int _I> float to_float(ap_fixed<_W, _I> v) {
  return v.to_float();
}

/*
 *------------------------------------------------------------------------------
 * Single-precision floating point union to convert between 32-bit int and float
 *------------------------------------------------------------------------------
 */

template <typename T> class fp_struct {};

union single_cast {
  float f;
  uint32_t i;
};

template <> class fp_struct<float> {
public:
  const static int EXP_INFNAN = 255;
  const static int EXP_BIAS = 127;
  const static int EXP_BITS = 8;
  const static int SIG_BITS = 23;
  const static int BITS = 32;

  fp_struct() {}
  fp_struct(float f) {
#if 1
    // def __SYNTHESIS__
    union single_cast dc;
    dc.f = f;
    ap_uint<32> data = dc.i;
#else
    uint32_t t;
    memcpy(&t, &f, sizeof(uint32_t));
    ap_uint<32> data = t;
#endif
    sign[0] = data[31];
    exp(7, 0) = data(30, 23);
    sig(22, 0) = data(22, 0);
  }
  fp_struct(ap_uint<32> data) {
    sign[0] = data[31];
    exp(7, 0) = data(30, 23);
    sig(22, 0) = data(22, 0);
  }
  fp_struct(uint32_t i) {
    ap_uint<32> data = i;
    sign[0] = data[31];
    exp(7, 0) = data(30, 23);
    sig(22, 0) = data(22, 0);
  }
  inline ap_uint<32> data() const {
    ap_uint<32> t;
    t[31] = sign[0];
    t(30, 23) = exp(7, 0);
    t(22, 0) = sig(22, 0);
    return t;
  }
  inline int expv() const { return exp - 127; }
  inline int32_t to_int() const { return data().to_int(); }
  inline float to_float() const {
#if 1
    // def __SYNTHESIS__
    union single_cast ret;
    ret.i = data().to_uint();
    return ret.f;
#else

    uint32_t t = data().to_uint();
    float f;
    memcpy(&f, &t, sizeof(uint32_t));
    return f;
#endif
  }
  inline void set_mantissa(ap_ufixed<1 + SIG_BITS, 1> mantissa) {
    ap_ufixed<SIG_BITS, 0> significand = mantissa;
    sig = significand(SIG_BITS - 1, 0);
  }
  inline ap_ufixed<1 + SIG_BITS, 1> mantissa() const {
    ap_ufixed<1 + SIG_BITS, 1> y = 0;
    y(y.wl() - 1, 0) = sig(SIG_BITS - 1, 0);
    y[y.wl() - 1] = 1; // The implicit '1' in IEEE format.
    return y;
  }
  inline float to_ieee() const { return to_float(); }
  inline int __signbit() const { return sign.to_int(); }

  static float infinity() {
    fp_struct<float> x;
    x.sign = 0;
    x.exp = -1;
    x.sig = 0;
    return x.to_ieee();
  }

  static float minus_infinity() {
    fp_struct<float> x;
    x.sign = 1;
    x.exp = -1;
    x.sig = 0;
    return x.to_ieee();
  }

  typedef uint32_t inttype;
  typedef ap_uint<32> data_type;
  ap_uint<1> sign;
  ap_uint<EXP_BITS> exp;
  ap_uint<SIG_BITS> sig;
};

#ifndef __SYNTHESIS__
static inline std::ostream &operator<<(std::ostream &os,
                                       const fp_struct<float> &s) {
#ifndef __HLS_SYN__
  os << s.to_float();
  os << " (sign: " << s.sign << ", exp: " << s.exp << ", sig: ";
  os << s.sig.to_string(8);
  os << " " << s.sig.to_string(2);
  os << ")";
#endif
  return os;
}
#endif

static inline void castSingle(float din, fp_struct<float> &dout) {
  fp_struct<float> t(din);
  dout = t;
}

static inline float castSingle(fp_struct<float> din) { return din.to_float(); }

static inline void dumpSingle(float da, fp_struct<float> ds) {
#ifdef _HLSCLIB_DEBUG_
#ifndef __SYNTHESIS__
  std::cout << ds << "\n";
  float sigd = ds.sig.to_int();
  sigd = 1.0 + sigd / 8388608.0;
  sigd = sigd * (pow(2, ds.expv()));
  printf("single: %f (sign: %d, exp: %d(%x), sig: %e(%x))\n", da,
         ds.sign.to_int(), ds.expv(), ds.exp.to_int(), sigd, ds.sig.to_int());
#else
  _AP_UNUSED_PARAM(da);
  _AP_UNUSED_PARAM(ds);
#endif
#else
  _AP_UNUSED_PARAM(da);
  _AP_UNUSED_PARAM(ds);
#endif
}

/*
 *------------------------------------------------------------------------------
 * Double-precision floating point union to convert between 64-bit int and
 *double
 *------------------------------------------------------------------------------
 */
union double_cast {
  double d;
  uint64_t i;
};

template <> class fp_struct<double> {
public:
  const static int EXP_INFNAN = 2047;
  const static int EXP_BIAS = 1023;
  const static int EXP_BITS = 11;
  const static int SIG_BITS = 52;
  const static int BITS = 64;

  fp_struct() {}
  fp_struct(double f) {
    union double_cast dc;
    dc.d = f;
    ap_uint<64> data = dc.i;
    sign[0] = data[63];
    exp(10, 0) = data(62, 52);
    sig(51, 0) = data(51, 0);
  }
  fp_struct(ap_uint<64> data) {
    sign[0] = data[63];
    exp(10, 0) = data(62, 52);
    sig(51, 0) = data(51, 0);
  }
  fp_struct(uint64_t i) {
    ap_uint<64> data = i;
    sign[0] = data[EXP_BITS + SIG_BITS + 1 - 1];
    exp(EXP_BITS - 1, 0) = data(EXP_BITS - 1 + SIG_BITS, SIG_BITS);
    sig(SIG_BITS - 1, 0) = data(SIG_BITS - 1, 0);
  }
  inline ap_uint<64> data() const {
    ap_uint<64> t;
    t[EXP_BITS + SIG_BITS + 1 - 1] = sign[0];
    t(EXP_BITS - 1 + SIG_BITS, SIG_BITS) = exp(EXP_BITS - 1, 0);
    t(SIG_BITS - 1, 0) = sig(SIG_BITS - 1, 0);
    return t;
  }
  inline int64_t to_int() const { return data().to_int64(); }
  inline int expv() const { return exp - 1023; }
  inline ap_uint<20> sig_msb() const { return sig(51, 32); }
  inline ap_uint<32> sig_lsb() const { return sig(31, 0); }
  inline double to_double() const {
    union double_cast ret;
    ret.i = data().to_uint64();
    return ret.d;
  }
  inline void set_mantissa(ap_ufixed<1 + SIG_BITS, 1> mantissa) {
    ap_ufixed<SIG_BITS, 0> significand = mantissa;
    sig = significand(SIG_BITS - 1, 0);
  }
  inline ap_ufixed<1 + SIG_BITS, 1> mantissa() const {
    ap_ufixed<1 + SIG_BITS, 1> y = 0;
    y(y.wl() - 1, 0) = sig(SIG_BITS - 1, 0);
    y[y.wl() - 1] = 1; // The implicit '1' in IEEE format.
    return y;
  }
  inline double to_ieee() const { return to_double(); }
  inline int __signbit() const { return sign.to_int(); }

  static double infinity() {
    fp_struct<double> x;
    x.sign = 0;
    x.exp = -1;
    x.sig = 0;
    return x.to_ieee();
  }

  static double minus_infinity() {
    fp_struct<double> x;
    x.sign = 1;
    x.exp = -1;
    x.sig = 0;
    return x.to_ieee();
  }

  typedef uint64_t inttype;
  typedef ap_uint<64> data_type;
  ap_uint<1> sign;
  ap_uint<EXP_BITS> exp;
  ap_uint<SIG_BITS> sig;
};

#ifndef __SYNTHESIS__
static inline std::ostream &operator<<(std::ostream &os,
                                       const fp_struct<double> &s) {
#ifndef __HLS_SYN__
  os << s.to_double() << " (sign: " << s.sign << ", exp: " << s.exp
     << ", sig: " << s.sig << " " << s.sig.to_string(2, true) << ")";
#else
  _AP_UNUSED_PARAM(s);
#endif
  return os;
}
#endif

static inline void castDouble(double din, fp_struct<double> &dout) {
  fp_struct<double> t(din);
  dout = t;
}

static inline double castDouble(fp_struct<double> din) {
  return din.to_double();
}

static inline void dumpDouble(double da, fp_struct<double> ds) {
#ifdef _HLSCLIB_DEBUG_
#ifndef __SYNTHESIS__
  std::cout << ds << "\n";
  double sigd = (ds.sig_msb().to_int() * 4294967296.0) + ds.sig_lsb().to_int();
  sigd = 1.0 + sigd / 4503599627370496.0;
  sigd = sigd * (pow(2, ds.expv()));
  printf("double: %f (sign: %d, exp: %d(%x), sig: %e(%x:%x))\n", da,
         ds.sign.to_int(), ds.expv(), ds.exp.to_int(), sigd,
         ds.sig_msb().to_int(), ds.sig_lsb().to_int());
#else
  _AP_UNUSED_PARAM(da);
  _AP_UNUSED_PARAM(ds);
#endif
#else
  _AP_UNUSED_PARAM(da);
  _AP_UNUSED_PARAM(ds);
#endif
}

/*
 *------------------------------------------------------------------------------
 * Half-precision floating point union to convert between 16-bit int and half
 *------------------------------------------------------------------------------
 */

#ifndef HAS_NO_HALF_TYPE
#ifdef __SYNTHESIS__
union half_cast {
  half d;
  uint16_t i;
};
#endif

template <> class fp_struct<half> {
public:
  const static int EXP_INFNAN = 31;
  const static int EXP_BIAS = 15;
  const static int EXP_BITS = 5;
  const static int SIG_BITS = 10;
  const static int BITS = 16;

  fp_struct() {}
  fp_struct(half f) {
#ifdef __SYNTHESIS__
    union half_cast dc;
    dc.d = f;
    ap_uint<16> data = dc.i;
#else
    ap_uint<16> data = (uint16_t)f.get_bits();
#endif
    sign[0] = data[EXP_BITS + SIG_BITS + 1 - 1];
    exp(EXP_BITS - 1, 0) = data(EXP_BITS - 1 + SIG_BITS, SIG_BITS);
    sig(SIG_BITS - 1, 0) = data(SIG_BITS - 1, 0);
  }
  fp_struct(ap_uint<16> data) {
    sign[0] = data[EXP_BITS + SIG_BITS + 1 - 1];
    exp(EXP_BITS - 1, 0) = data(EXP_BITS - 1 + SIG_BITS, SIG_BITS);
    sig(SIG_BITS - 1, 0) = data(SIG_BITS - 1, 0);
  }
  fp_struct(uint16_t i) {
    ap_uint<16> data = i;
    sign[0] = data[EXP_BITS + SIG_BITS + 1 - 1];
    exp(EXP_BITS - 1, 0) = data(EXP_BITS - 1 + SIG_BITS, SIG_BITS);
    sig(SIG_BITS - 1, 0) = data(SIG_BITS - 1, 0);
  }
  inline ap_uint<16> data() const {
    ap_uint<16> t;
    t[EXP_BITS + SIG_BITS + 1 - 1] = sign[0];
    t(EXP_BITS - 1 + SIG_BITS, SIG_BITS) = exp(EXP_BITS - 1, 0);
    t(SIG_BITS - 1, 0) = sig(SIG_BITS - 1, 0);
    return t;
  }
  inline int expv() const { return exp - EXP_BIAS; }
  inline int16_t to_int() const { return uint16_t(data().to_int()); }
  inline half to_half() const {
#ifdef __SYNTHESIS__
    union half_cast ret;
    ret.i = data().to_uint64();
    return ret.d;
#else
    half h;
    h.set_bits(half::uint16(data().to_uint()));
    return h;
#endif
  }
  inline void set_mantissa(ap_ufixed<1 + SIG_BITS, 1> mantissa) {
    ap_ufixed<SIG_BITS, 0> significand = mantissa;
    sig = significand(SIG_BITS - 1, 0);
  }
  inline ap_ufixed<1 + SIG_BITS, 1> mantissa() const {
    ap_ufixed<1 + SIG_BITS, 1> y = 0;
    y(y.wl() - 1, 0) = sig(SIG_BITS - 1, 0);
    y[y.wl() - 1] = 1; // The implicit '1' in IEEE format.
    return y;
  }
  inline half to_ieee() const { return to_half(); }
  inline int __signbit() const { return sign.to_int(); }

  static half infinity() {
    fp_struct<half> x;
    x.sign = 0;
    x.exp = -1;
    x.sig = 0;
    return x.to_ieee();
  }

  static half minus_infinity() {
    fp_struct<half> x;
    x.sign = 1;
    x.exp = -1;
    x.sig = 0;
    return x.to_ieee();
  }

  typedef uint16_t inttype;
  typedef ap_uint<16> data_type;
  ap_uint<1> sign;
  ap_uint<EXP_BITS> exp;
  ap_uint<SIG_BITS> sig;
};

#ifndef __SYNTHESIS__
static inline std::ostream &operator<<(std::ostream &os,
                                       const fp_struct<half> &s) {
#ifndef __HLS_SYN__
  os << (float)(s.to_half()) << " (sign: " << s.sign << ", exp: " << s.exp
     << ", sig: " << s.sig << " " << s.sig.to_string(2, true) << ")";
#else
  _AP_UNUSED_PARAM(s);
#endif
  return os;
}
#endif

static inline void castHalf(half din, fp_struct<half> &dout) {
  fp_struct<half> t(din);
  dout = t;
}

static inline half castHalf(fp_struct<half> din) { return din.to_half(); }

static inline void dumpHalf(half da, fp_struct<half> ds) {
#ifdef _HLSCLIB_DEBUG_
#ifndef __SYNTHESIS__
  std::cout << ds << "\n";
  half sigd = ds.sig.to_int();
  sigd = 1.0 + sigd / 1024.0;
  sigd = sigd * (pow(2, ds.expv()));
  printf("half: %f (sign: %d, exp: %d(%x), sig: %e(%x))\n", (float)da,
         ds.sign.to_int(), ds.expv(), ds.exp.to_int(), (float)sigd,
         ds.sig.to_int());
#else
  _AP_UNUSED_PARAM(da);
  _AP_UNUSED_PARAM(ds);
#endif
#else
  _AP_UNUSED_PARAM(da);
  _AP_UNUSED_PARAM(ds);
#endif
}
#endif

/*
 *------------------------------------------------------------------------------
 * Raise a value to a certain power (B^N).
 *
 * This class is necessary in template arguments due to its static const nature
 * and the fact that it performs the power operation as part of the recursive
 * class declaration. A standard recursive power function would not return
 * a static const value.
 *
 *------------------------------------------------------------------------------
 */
template <unsigned int _Base, unsigned int _Num> class Power {
public:
  static const unsigned int Value = _Base * Power<_Base, _Num - 1>::Value;
};

template <unsigned int _Base> class Power<_Base, 0> {
public:
  static const unsigned int Value = 1;
};

/*
 *------------------------------------------------------------------------------
 * Calculate the minimum # of bits to store the given signed integer value.
 * BitWidth<2>::Value == 3
 * BitWidth<3>::Value == 3
 * BitWidth<4>::Value == 4
 *------------------------------------------------------------------------------
 */
template <unsigned int _Num, unsigned int _I = _Num / 2> class BitWidth {
public:
  static const unsigned int Value = 1 + BitWidth<_Num, _I / 2>::Value;
};

template <unsigned int _Num> class BitWidth<_Num, 0> {
public:
  static const unsigned int Value = 2;
};

/*
 *------------------------------------------------------------------------------
 * Calculate the minimum # of bits to store the given unsigned integer value.
 * UnsignedBitWidth<2>::Value == 2
 * UnsignedBitWidth<3>::Value == 2
 * UnsignedBitWidth<4>::Value == 3
 *------------------------------------------------------------------------------
 */
template <unsigned int _Num, unsigned int _I = _Num / 2>
class UnsignedBitWidth {
public:
  static const unsigned int Value = 1 + UnsignedBitWidth<_Num, _I / 2>::Value;
};

template <unsigned int _Num> class UnsignedBitWidth<_Num, 0> {
public:
  static const unsigned int Value = 1;
};

/*
 *------------------------------------------------------------------------------
 * return num of bits of a specific type
 *
 * This class returns the bitwidth result of a specific type
 *------------------------------------------------------------------------------
 */
template <typename T> class Type_BitWidth {
public:
  static const unsigned int Value = 8 * sizeof(T);
};

template <int W> class Type_BitWidth<ap_uint<W>> {
public:
  static const unsigned int Value = W;
};

template <int W> class Type_BitWidth<ap_int<W>> {
public:
  static const unsigned int Value = W;
};

template <int W, int I> class Type_BitWidth<ap_ufixed<W, I>> {
public:
  static const unsigned int Value = W;
};

template <int W, int I> class Type_BitWidth<ap_fixed<W, I>> {
public:
  static const unsigned int Value = W;
};

/*
*******************************************************************************
* Table class
*
* T: table data type
* N: Depth of table entries
*
* public:
*   dummy    Table data type
*   array[N] Table array
*******************************************************************************
*/

template <typename _T, int _Num, int _I = _Num - 1>
class Table : public Table<_T, _Num, _I - 1> {
public:
  typedef typename _T::TableType TableType;
  static const typename _T::TableType dummy;
  static const int size = _Num;
};

template <typename _T, int _Num> class Table<_T, _Num, 0> {
public:
  static const typename _T::TableType dummy;
  static typename _T::TableType array[_Num];
};

/*
 * Declares the templatized and static Table dummy variable
 *
 * Assign the global static const Table::dummy variable to the
 * associated Table entry by invoking T::apply, assigning it to array[I]
 * and adding smaller templates of Table::dummy to it, thereby recursively
 * assigning the smaller templates for Tables..
 */

template <typename _T, int _Num, int _I>
const typename _T::TableType Table<_T, _Num, _I>::dummy =
    Table<_T, _Num, 0>::array[_I] = _T::apply(_I, _Num) +
                                    0 * Table<_T, _Num, _I - 1>::dummy;

template <typename _T, int _Num>
const typename _T::TableType Table<_T, _Num, 0>::dummy =
    Table<_T, _Num, 0>::array[0] = _T::apply(0, _Num);

/*
 * Declares the templatized and static Table array
 */
template <typename _T, int _Num>
typename _T::TableType Table<_T, _Num, 0>::array[_Num];

// Some standard junk... this is in the new standard and in boost,
// but for a few definitions it's not worth the dependency
template <class T> struct is_fptype { static const bool value = false; };
template <> struct is_fptype<float> { static const bool value = true; };
template <> struct is_fptype<double> { static const bool value = true; };
template <> struct is_fptype<half> { static const bool value = true; };

template <class T> struct is_integraltype { static const bool value = false; };
template <> struct is_integraltype<int> { static const bool value = true; };
template <> struct is_integraltype<unsigned int> {
  static const bool value = true;
};
template <> struct is_integraltype<char> { static const bool value = true; };
template <> struct is_integraltype<signed char> {
  static const bool value = true;
};
template <> struct is_integraltype<unsigned char> {
  static const bool value = true;
};
template <> struct is_integraltype<short> { static const bool value = true; };
template <> struct is_integraltype<unsigned short> {
  static const bool value = true;
};
template <> struct is_integraltype<long> { static const bool value = true; };
template <> struct is_integraltype<unsigned long> {
  static const bool value = true;
};
template <> struct is_integraltype<long long> {
  static const bool value = true;
};
template <> struct is_integraltype<unsigned long long> {
  static const bool value = true;
};
template <int W> struct is_integraltype<ap_int<W>> {
  static const bool value = true;
};
template <int W> struct is_integraltype<ap_uint<W>> {
  static const bool value = true;
};

template <class T> struct is_fixedtype { static const bool value = false; };
template <int W, int I, ap_q_mode Q, ap_o_mode O>
struct is_fixedtype<ap_fixed<W, I, Q, O>> {
  static const bool value = true;
};
template <int W, int I, ap_q_mode Q, ap_o_mode O>
struct is_fixedtype<ap_ufixed<W, I, Q, O>> {
  static const bool value = true;
};

namespace hls {
template <bool B, class T = void> struct enable_if {};

template <class T> struct enable_if<true, T> { typedef T type; };
template <typename T, T _v> struct integral_constant {
  static const T value = _v;
  typedef T value_type;
  typedef integral_constant<T, _v> type;
  operator value_type() { return value; }
};

typedef integral_constant<bool, true> true_type;
typedef integral_constant<bool, false> false_type;

template <typename T1, typename T2> struct is_same;

template <typename T1, typename T2> struct is_same : public false_type {};

template <typename T1> struct is_same<T1, T1> : public true_type {};

template <typename T>
struct is_arithmetic
    : public integral_constant<bool, (is_integraltype<T>::value ||
                                      is_fptype<T>::value)> {};
} // namespace hls

template <typename T1, typename T2> struct enable_or {
  static const bool value = T1::value || T2::value;
};

template <typename T1, typename T2> struct enable_and {
  static const bool value = T1::value && T2::value;
};

template <typename T, bool = is_integraltype<T>::value> struct __promote {
  typedef double type;
};

template <typename T> struct __promote<T, false> {};

template <> struct __promote<double> { typedef double type; };

template <> struct __promote<float> { typedef float type; };

template <> struct __promote<half> { typedef half type; };

// End standard junk

#endif
