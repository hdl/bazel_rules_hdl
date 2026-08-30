// 67d7842dbbe25473c3c32b93c0da8047785f30d78e8a024de1b57352245f9689
/*
#-  (c) Copyright 2011-2021 Xilinx, Inc. All rights reserved.
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
#ifndef __HLS_HALF_SIM_H__
#define __HLS_HALF_SIM_H__
// This is just for csim and cosim instead of synthesis.
// That is to say,  __SYNTHESIS__  are not defined.

#ifndef __cplusplus
#error C++ is required to include this header file
#endif

#if defined(__GNUC__) || defined(__clang__) || defined(_MSC_VER)

#include <iostream>
#include <limits>
// Forward declaration of ap_fixed_base.
#include "ap_decl.h"

class half {
public:
  typedef unsigned short uint16;
  template <typename T1, typename T2> struct half_traits;

  /* 16-bit float following IEEE 754
     16 bits inside             float value
  0 00000 0000000000 = 0x0000 = 0
  1 00000 0000000000 = 0x8000 = -0

  0 11111 0000000000 = 0x7c00 = infinity
  1 11111 0000000000 = 0xfc00 = -infinity
  0 11110 1111111111 = 0x7bff = max  = 65504
  x 11111 yyyyyyyyyy =        = nan,  in which yyyyyyyy !=0

  */
  static const uint16 nan = 0x7FFF; // greater than 7c00 , it's just a flag ,
                                    // and  nan > 0x7C00 except 0xfc00
  half() : m_data() {}
  half(const half &rh) : m_data(rh.m_data) {}
  half(float rh) { m_data = float2half(rh); }

  /// Conversion constructor from AP types.
  template <int _AP_W, int _AP_I, bool _AP_S, ap_q_mode _AP_Q, ap_o_mode _AP_O,
            int _AP_N>
  half(const ap_fixed_base<_AP_W, _AP_I, _AP_S, _AP_Q, _AP_O, _AP_N> &rhs) {
    std::cout << "WARNING: explicit method ap_fixed::to_half() should be used "
                 "to convert ap_fixed to half."
              << std::endl;
    *this = rhs.to_half();
  }

  template <int _AP_W, bool _AP_S> half(const ap_int_base<_AP_W, _AP_S> &rhs) {
    *this = rhs.to_half();
  }

  template <int _AP_W, int _AP_I, bool _AP_S, ap_q_mode _AP_Q, ap_o_mode _AP_O,
            int _AP_N>
  half &operator=(
      const ap_fixed_base<_AP_W, _AP_I, _AP_S, _AP_Q, _AP_O, _AP_N> &rhs) {
    return *this = rhs.to_half();
  }
  template <int _AP_W, bool _AP_S>
  half &operator=(const ap_int_base<_AP_W, _AP_S> &rhs) {
    return *this = rhs.to_half();
  }

  static bool half_isnan(half hf) { return (hf.m_data & 0x7FFF) > 0x7C00; }
  operator float() const { return half2float(m_data); }

  half &operator=(float rhs) {
    m_data = float2half(rhs);
    return *this;
  }

public:
  //---------- arithemic operations------/
  //  arithm operations between half and other data-type
  //  promotion  half to float implictly or explictly during operations.

  // plus T + half
  template <typename T>
  friend typename half::half_traits<T, half>::rtvl_t
  operator+(const T &lhs, const half &rhs) {
    // return static_cast<float>(lhs) + static_cast<float>(rhs);
    return (lhs) + static_cast<float>(rhs);
  }
  // plus half + T
  template <typename T>
  typename half::half_traits<half, T>::rtvl_t operator+(const T &rhs) {
    // return static_cast<float>(*this) + static_cast<float>(rhs);
    return static_cast<float>(*this) + (rhs);
  }
  // plus half + half
  half operator+(const half &rhs) {
    if (half_isnan(*this) || half_isnan(rhs)) {
      half t;
      t.set_bits(half::nan);
      return t;
    } else
      return half(static_cast<float>(*this) + static_cast<float>(rhs));
  }

  // sub  T - half
  template <typename T>
  friend typename half::half_traits<T, half>::rtvl_t
  operator-(const T &lhs, const half &rhs) {
    // return static_cast<float>(lhs) - static_cast<float>(rhs);
    return (lhs) - static_cast<float>(rhs);
  }
  // sub  half - T
  template <typename T>
  typename half::half_traits<half, T>::rtvl_t operator-(const T &rhs) {
    // return static_cast<float>(*this) - static_cast<float>(rhs);
    return static_cast<float>(*this) - (rhs);
  }
  // sub  half - half
  half operator-(const half &rhs) {
    if (half_isnan(*this) || half_isnan(rhs)) {
      half t;
      t.set_bits(half::nan);
      return t;
    } else
      return half(static_cast<float>(*this) - static_cast<float>(rhs));
  }

  // mul T * half
  template <typename T>
  friend typename half::half_traits<T, half>::rtvl_t
  operator*(const T &lhs, const half &rhs) {
    // return static_cast<float>(lhs) * static_cast<float>(rhs);
    return (lhs) * static_cast<float>(rhs);
  }
  // mul half * T
  template <typename T>
  typename half::half_traits<half, T>::rtvl_t operator*(const T &rhs) {
    // return static_cast<float>(*this) * static_cast<float>(rhs);
    return static_cast<float>(*this) * (rhs);
  }
  // mul half * half
  half operator*(const half &rhs) {
    if (half_isnan(*this) || half_isnan(rhs)) {
      half t;
      t.set_bits(half::nan);
      return t;
    } else
      return half(static_cast<float>(*this) * static_cast<float>(rhs));
  }

  // div  T / half
  template <typename T>
  friend typename half::half_traits<T, half>::rtvl_t
  operator/(const T &lhs, const half &rhs) {
    // return static_cast<float>(lhs) / static_cast<float>(rhs);
    return (lhs) / static_cast<float>(rhs);
  }
  // div half / T
  template <typename T>
  typename half::half_traits<half, T>::rtvl_t operator/(const T &rhs) {
    // return static_cast<float>(*this) / static_cast<float>(rhs);
    return static_cast<float>(*this) / (rhs);
  }
  // div half/half
  half operator/(const half &rhs) {
    if (half_isnan(*this) || half_isnan(rhs)) {
      half t;
      t.set_bits(half::nan);
      return t;
    } else
      return half(static_cast<float>(*this) / static_cast<float>(rhs));
  }

  /****************begin  unary operations **************/
  template <typename T> half &operator+=(const T &rhs) {
    float f = static_cast<float>(*this) + static_cast<float>(rhs);
    return *this = half(f);
  }

  half &operator+=(const half &rhs) {
    if (half_isnan(*this) || half_isnan(rhs))
      m_data = half::nan;
    else
      *this += static_cast<float>(rhs);
    return *this;
  }

  template <typename T> half &operator-=(const T &rhs) {
    float f = static_cast<float>(*this) - static_cast<float>(rhs);
    return *this = half(f);
  }

  half &operator-=(const half &rhs) {
    if (half_isnan(*this) || half_isnan(rhs))
      m_data = half::nan;
    else
      *this -= static_cast<float>(rhs);
    return *this;
  }

  template <typename T> half &operator*=(const T &rhs) {
    float f = static_cast<float>(*this) * static_cast<float>(rhs);
    return *this = half(f);
  }

  half &operator*=(const half &rhs) {
    if (half_isnan(*this) || half_isnan(rhs))
      m_data = half::nan;
    else
      *this *= static_cast<float>(rhs);
    return *this;
  }

  template <typename T> half &operator/=(const T &rhs) {
    float f = static_cast<float>(*this) / static_cast<float>(rhs);
    return *this = half(f);
  }

  half &operator/=(const half &rhs) {
    if (half_isnan(*this) || half_isnan(rhs))
      m_data = half::nan;
    else
      *this /= static_cast<float>(rhs);
    return *this;
  }

  /****************begin  unary operations **************/
  /// Prefix increment.
  half &operator++() { return *this += 1.0f; }

  /// Prefix decrement.
  half &operator--() { return *this -= 1.0f; }

  /// Postfix increment.
  half operator++(int) {
    half out(*this);
    ++*this;
    return out;
  }

  /// Postfix decrement.
  half operator--(int) {
    half out(*this);
    --*this;
    return out;
  }

  void set_bits(uint16 d) { m_data = d; }

  uint16 get_bits() { return m_data; }

private:
  // Unsigned integer of (at least) 16 bits width.
  uint16 m_data;

  union fp_union {
    float flt;
    unsigned int u32;
  };
  uint16 float2half(const float &rhs) {
    // subnormal value returs 0
    // if( -6.10352e-05<rhs && rhs< 6.10352e-05)
    float abs_rhs = rhs > 0 ? rhs : (-rhs);
    if (abs_rhs < 6.10352e-05)
      return 0;
    fp_union fp;
    fp.flt = rhs;
    unsigned int u = fp.u32;
    unsigned int exp32 = u & 0x7f800000;
    unsigned int mant = u & 0x7fffff;
    uint16 s = (u & 0x80000000) >> 16;
    uint16 e = exp32 >> 23;
    uint16 m = mant >> 13;
    if ((e == 0xff && m == 0) || abs_rhs > 65504)
      return (0x7c00 | s); // + inf -inf
    if (e == 0xff && m != 0)
      return 0x7fff;        // nan
    int ee = e - 127 + 15;  // - float_bias +half_bias
    uint16 l_e = ee & 0x1f; // low 5 bitt 8bits e & 0001 1111
    uint16 d = s | (l_e << 10) | m;
    return d;
  }
  float half2float(const uint16 &rhs) const {
    float d;
    uint16 sign = rhs & 0x8000;
    uint16 mant = rhs & 0x03ff;
    uint16 exp = rhs & 0x7c00;
    if (rhs == 0x7c00)
      return std::numeric_limits<float>::infinity();
    if (rhs == 0xfc00)
      return -std::numeric_limits<float>::infinity();

    if (rhs == 0x0)
      return 0.0f;
    else if (rhs == 0x8000)
      return -0.0f;
    if (exp == 0x7c00 && mant != 0) {
      return std::numeric_limits<float>::quiet_NaN(); // nan;
    }

    if (exp == 0 && mant != 0) {
      // subnormal
      float e14 = 6.10352e-05; // pow(2.0,-14);
      d = (e14)*mant / 1024;
    } else {
      exp = exp >> 10;
      int e = exp - 15;
      float ez = 1.0f;
      if (e > 0)
        for (int i = 0; i < e; ++i)
          ez *= 2;
      else
        for (int i = 0; i < -e; ++i)
          ez /= 2;
      d = ez * (1 + mant / 1024.0f);
    }
    d = (sign == 0) ? d : -d;
    return d;
  }

  friend std::ostream &operator<<(std::ostream &out, const half &hf) {
    float f = static_cast<float>(hf);
    return out << f;
  }

  friend std::istream &operator>>(std::istream &in, half &hf) {
    float f;
    if (in >> f)
      hf = static_cast<half>(f);
    return in;
  }
}; // class half

template <> struct half::half_traits<char, half> { typedef half rtvl_t; };

template <> struct half::half_traits<signed char, half> {
  typedef half rtvl_t;
};

template <> struct half::half_traits<unsigned char, half> {
  typedef half rtvl_t;
};

template <> struct half::half_traits<short, half> { typedef half rtvl_t; };

template <> struct half::half_traits<unsigned short, half> {
  typedef half rtvl_t;
};

template <> struct half::half_traits<int, half> { typedef half rtvl_t; };

template <> struct half::half_traits<unsigned int, half> {
  typedef half rtvl_t;
};

template <> struct half::half_traits<float, half> { typedef float rtvl_t; };

template <> struct half::half_traits<double, half> { typedef double rtvl_t; };

template <> struct half::half_traits<long, half> {
  // typedef double rtvl_t;
  typedef half rtvl_t;
};

template <> struct half::half_traits<unsigned long, half> {
  typedef half rtvl_t;
  // typedef double rtvl_t;
};

template <> struct half::half_traits<half, char> { typedef half rtvl_t; };

template <> struct half::half_traits<half, signed char> {
  typedef half rtvl_t;
};

template <> struct half::half_traits<half, unsigned char> {
  typedef half rtvl_t;
};

template <> struct half::half_traits<half, short> { typedef half rtvl_t; };

template <> struct half::half_traits<half, unsigned short> {
  typedef half rtvl_t;
};

template <> struct half::half_traits<half, int> { typedef half rtvl_t; };

template <> struct half::half_traits<half, unsigned int> {
  typedef half rtvl_t;
};

template <> struct half::half_traits<half, float> { typedef float rtvl_t; };

template <> struct half::half_traits<half, double> { typedef double rtvl_t; };

template <> struct half::half_traits<half, long> {
  // typedef double rtvl_t;
  typedef half rtvl_t;
};

template <> struct half::half_traits<half, unsigned long> {
  typedef half rtvl_t;
  // typedef double rtvl_t;
};

#endif // (__GNUC__ ) || (__clang__) || (_MSC_VER)
#endif // __HLS_HALF_SIM__
