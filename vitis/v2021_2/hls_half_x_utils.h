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
#ifndef __HLS_HALF_UTILS_H__
#define __HLS_HALF_UTILS_H__

#ifndef __cplusplus
#ifndef __SYNTHESIS__
#error C++ is required to include this header file
#endif
#endif

#ifndef __SYNTHESIS__
#include <cmath>
#include <iostream>
#include <limits>
#include <climits>

#if defined(__clang__) // clang
#if (defined(__GXX_EXPERIMENTAL_CXX0X__) || __cplusplus >= 201103L) && !defined(HALF_ENABLE_CPP11_LONG_LONG)
#define HALF_ENABLE_CPP11_LONG_LONG 1
#endif
#elif defined(__GNUC__) // gcc
#if !defined(HALF_ENABLE_CPP11_LONG_LONG)
#define HALF_ENABLE_CPP11_LONG_LONG 1
#endif
#elif defined(_MSC_VER) // Visual C++
#if _MSC_VER >= 1310 && !defined(HALF_ENABLE_CPP11_LONG_LONG)
#define HALF_ENABLE_CPP11_LONG_LONG 1
#endif
#endif

#define FP_FAST_FMAH 1

#ifndef FP_ILOGB0
#define FP_ILOGB0 INT_MIN
#endif
#ifndef FP_ILOGBNAN
#define FP_ILOGBNAN INT_MAX
#endif
#ifndef FP_SUBNORMAL
#define FP_SUBNORMAL 0
#endif
#ifndef FP_ZERO
#define FP_ZERO 1
#endif

#ifndef FP_NAN
#define FP_NAN 2
#endif
#ifndef FP_INFINITE
#define FP_INFINITE 3
#endif
#ifndef FP_NORMAL
#define FP_NORMAL 4
#endif

#ifndef HALF_ROUND_STYLE
#define HALF_ROUND_STYLE 1 // = std::round_indeterminate
#endif
#ifndef HALF_ROUND_TIES_TO_EVEN
#define HALF_ROUND_TIES_TO_EVEN 1 // ties away from zero
#endif
#ifdef _MSC_VER
#include <algorithm>
#endif
class half;
namespace detail {

/* 16-bit float following IEEE 754
   16 bits inside             float value
0 00000 0000000000 = 0x0000 = 0
1 00000 0000000000 = 0x8000 = -0

0 11111 0000000000 = 0x7c00 = infinity
1 11111 0000000000 = 0xfc00 = -infinity
0 11110 1111111111 = 0x7bff = max  = 65504
x 11111 yyyyyyyyyy =        = nan,  in which yyyyyyyy !=0

*/

inline bool isfinite(half arg) {
    return (arg.get_bits() & 0x7C00) != 0x7C00;
}

inline bool isinf(half arg) {
    return (arg.get_bits() & 0x7FFF) == 0x7C00;
}

inline bool isnan(half arg) {
    return (arg.get_bits() & 0x7FFF) > 0x7C00;
}

inline bool isnormal(half arg) {
    return ((arg.get_bits() & 0x7C00) != 0) & ((arg.get_bits() & 0x7C00) != 0x7C00);
}

inline bool signbit(half arg) {
    return (arg.get_bits() & 0x8000) != 0;
}

inline int fpclassify(half arg) {
    unsigned int abs = arg.get_bits() & 0x7FFF;
    if (abs == 0x7C00) return FP_INFINITE;
    if (abs > 0x3FF) return FP_NORMAL;
    return abs ? FP_SUBNORMAL : FP_ZERO;
}

inline half fmod(half x, half y) {
    return (std::fmod(x, y));
}

inline half sinh(half arg) {
    return std::sinh(arg);
}

inline half cosh(half arg) {
    return std::cosh(arg);
}

inline half sin(half arg) {
    return std::sin(arg);
}

inline half cos(half arg) {
    return std::cos(arg);
}
inline half frexp(half arg, int* exp) {
    unsigned int m = arg.get_bits() & 0x7FFF;
    if (m >= 0x7C00 || !m) return *exp = 0, arg;
    int e = m >> 10;
    if (!e)
        for (m <<= 1; m < 0x400; m <<= 1, --e)
            ;

    *exp = e - 14;
    half t;
    t.set_bits(static_cast<half::uint16>((arg.get_bits() & 0x8000) | 0x3800 | (m & 0x3FF)));
    return t;
}

inline half modf(half arg, half* iptr) {
    half t;
    unsigned int e = arg.get_bits() & 0x7C00;
    if (e > 0x6000) {
        *iptr = arg;
        t.set_bits(arg.get_bits() & 0x8000);
        return (e == 0x7C00 && (arg.get_bits() & 0x3FF)) ? arg : t;
    }
    if (e < 0x3C00) return iptr->set_bits(arg.get_bits() & 0x8000), arg;
    e >>= 10;
    unsigned int mask = (1 << (25 - e)) - 1, m = arg.get_bits() & mask;
    iptr->set_bits(arg.get_bits() & ~mask);
    if (!m)
        t.set_bits(arg.get_bits() & 0x8000);
    else {
        for (; m < 0x400; m <<= 1, --e)
            ;
        t.set_bits(static_cast<half::uint16>((arg.get_bits() & 0x8000) | (e << 10) | (m & 0x3FF)));
    }
    return t;
}

inline int ilogb(half arg) {
    int exp = arg.get_bits() & 0x7FFF;
    if (!exp) return FP_ILOGB0;
    if (exp < 0x7C00) {
        if (!(exp >>= 10))
            for (unsigned int m = (arg.get_bits() & 0x3FF); m < 0x200; m <<= 1, --exp)
                ;
        return exp - 15;
    }
    if (exp > 0x7C00) return FP_ILOGBNAN;
    return INT_MAX;
}
inline float fdim(float x, float y) {
    return ((x <= y) ? 0.0f : (x - y));
}
/// Wrapper for binary half-precision  needing specialization for individual argument types.
/// \tparam T first argument type
/// \tparam U first argument type
template <typename T, typename U>
struct binary_specialized {
    static float fmin(float x, float y) {
        if (isnan(x)) return y;
        if (isnan(y)) return x;
        return std::min(x, y);
    }

    static float fmax(float x, float y) {
        if (isnan(x)) return y;
        if (isnan(y)) return x;
        return std::max(x, y);
    }
};
template <>
struct binary_specialized<half, half> {
    static half fmin(half x, half y) {
        if (isnan(x)) return y;
        if (isnan(y)) return x;
        return ((signbit(x) ? (static_cast<int>(0x8000) - x.get_bits()) : static_cast<int>(x.get_bits())) >
                (signbit(y) ? (static_cast<int>(0x8000) - y.get_bits()) : static_cast<int>(y.get_bits())))
                   ? y
                   : x;
    }
    static half fmax(half x, half y) {
        if (isnan(x)) return y;
        if (isnan(y)) return x;
        return ((signbit(x) ? (static_cast<int>(0x8000) - x.get_bits()) : static_cast<int>(x.get_bits())) <
                (signbit(y) ? (static_cast<int>(0x8000) - y.get_bits()) : static_cast<int>(y.get_bits())))
                   ? y
                   : x;
    }
};

inline half fmax(half x, half y) {
    return binary_specialized<half, half>::fmax(x, y);
}
inline float fmax(half x, float y) {
    return binary_specialized<half, float>::fmax(x, y);
}
inline float fmax(float x, half y) {
    return binary_specialized<float, half>::fmax(x, y);
}
inline float fmax(float x, float y) {
    return binary_specialized<float, float>::fmax(x, y);
}

inline half fmin(half x, half y) {
    return binary_specialized<half, half>::fmin(x, y);
}
inline float fmin(half x, float y) {
    return binary_specialized<half, float>::fmin(x, y);
}
inline float fmin(float x, half y) {
    return binary_specialized<float, half>::fmin(x, y);
}
inline float fmin(float x, float y) {
    return binary_specialized<float, float>::fmin(x, y);
}

inline half fabs(half x) {
    half t;
    t.set_bits(x.get_bits() & 0x7FFF);
    return t;
}
inline half abs(half x) {
    half t;
    t.set_bits(x.get_bits() & 0x7FFF);
    return t;
}

inline half scalbln(half arg, long exp) {
    long e = arg.get_bits() & 0x7C00;
    if (e == 0x7C00) return arg;
    unsigned int m = arg.get_bits() & 0x3FF;
    if (e >>= 10)
        m |= 0x400;
    else {
        if (!m) return arg;
        for (m <<= 1; m < 0x400; m <<= 1, --e)
            ;
    }
    e += exp;
    half::uint16 value = arg.get_bits() & 0x8000;
    if (e > 30) {
        value |= 0x7C00;
    } else if (e > 0)
        value |= (e << 10) | (m & 0x3FF);
    else if (e > -11) {
        //	if(half::round_style == std::round_to_nearest)
        {
            m += 1 << -e;
#if HALF_ROUND_TIES_TO_EVEN
            m -= (m >> (1 - e)) & 1;
#endif
        }
        value |= m >> (1 - e);
    }
    half t;
    t.set_bits(value);
    return t;
}

inline half ldexp(half arg, int exp) {
    return scalbln(arg, exp);
}
inline half ldexp(float arg, int exp) {
    return scalbln(arg, exp);
}

//-------------------------------------------------------------------------------------------//

/// Convert half-precision floating point to integer.
/// \tparam R rounding mode to use, `std::round_indeterminate` for fastest rounding
/// \tparam E `true` for round to even, `false` for round away from zero
/// \tparam T type to convert to (buitlin integer type with at least 16 bits precision, excluding any implicit sign
/// bits) \param value binary representation of half-precision value \return integral value
template <std::float_round_style R, bool E, typename T>
T half2int_impl(half::uint16 value) {
    unsigned int e = value & 0x7FFF;
    if (e >= 0x7C00) return (value & 0x8000) ? std::numeric_limits<T>::min() : std::numeric_limits<T>::max();
    if (e < 0x3800) {
        if (R == std::round_toward_infinity)
            return T(~(value >> 15) & (e != 0));
        else if (R == std::round_toward_neg_infinity)
            return -T(value > 0x8000);
        return T();
    }
    int m = (value & 0x3FF) | 0x400;
    e >>= 10;
    if (e < 25) {
        if (R == std::round_indeterminate || R == std::round_toward_zero)
            m >>= 25 - e;
        else {
            if (R == std::round_to_nearest)
                m += (1 << (24 - e)) - (~(m >> (25 - e)) & E);
            else if (R == std::round_toward_infinity)
                m += ((value >> 15) - 1) & ((1 << (25 - e)) - 1U);
            else if (R == std::round_toward_neg_infinity)
                m += -(value >> 15) & ((1 << (25 - e)) - 1U);
            m >>= 25 - e;
        }
    } else
        m <<= e - 25;
    //			if(std::numeric_limits<T>::digits < 16)
    //				return std::min(std::max(m, static_cast<int>(std::numeric_limits<T>::min())),
    // static_cast<int>(std::numeric_limits<T>::max()));
    return static_cast<T>((value & 0x8000) ? -m : m);
}

/// Convert half-precision floating point to integer.
/// \tparam R rounding mode to use, `std::round_indeterminate` for fastest rounding
/// \tparam T type to convert to (buitlin integer type with at least 16 bits precision, excluding any implicit sign
/// bits) \param value binary representation of half-precision value \return integral value
template <std::float_round_style R, typename T>
T half2int(half::uint16 value) {
    return half2int_impl<R, HALF_ROUND_TIES_TO_EVEN, T>(value);
}

/// Convert half-precision floating point to integer using round-to-nearest-away-from-zero.
/// \tparam T type to convert to (buitlin integer type with at least 16 bits precision, excluding any implicit sign
/// bits) \param value binary representation of half-precision value \return integral value
template <typename T>
T half2int_up(half::uint16 value) {
    return half2int_impl<std::round_to_nearest, 0, T>(value);
}

/// Round half-precision number to nearest integer value.
/// \tparam R rounding mode to use, `std::round_indeterminate` for fastest rounding
/// \tparam E `true` for round to even, `false` for round away from zero
/// \param value binary representation of half-precision value
/// \return half-precision bits for nearest integral value
template <std::float_round_style R, bool E>
half::uint16 round_half_impl(half::uint16 value) {
    unsigned int e = value & 0x7FFF;
    half::uint16 result = value;
    if (e < 0x3C00) {
        result &= 0x8000;
        if (R == std::round_to_nearest)
            result |= 0x3C00U & -(e >= (0x3800 + E));
        else if (R == std::round_toward_infinity)
            result |= 0x3C00U & -(~(value >> 15) & (e != 0));
        else if (R == std::round_toward_neg_infinity)
            result |= 0x3C00U & -(value > 0x8000);
    } else if (e < 0x6400) {
        e = 25 - (e >> 10);
        unsigned int mask = (1 << e) - 1;
        if (R == std::round_to_nearest)
            result += (1 << (e - 1)) - (~(result >> e) & E);
        else if (R == std::round_toward_infinity)
            result += mask & ((value >> 15) - 1);
        else if (R == std::round_toward_neg_infinity)
            result += mask & -(value >> 15);
        result &= ~mask;
    }
    return result;
}

template <std::float_round_style R>
half::uint16 round_half(half::uint16 value) {
    return round_half_impl<R, HALF_ROUND_TIES_TO_EVEN>(value);
}

inline half::uint16 round_half_up(half::uint16 value) {
    return round_half_impl<std::round_to_nearest, 0>(value);
}

inline half floor(half arg) {
    half t;
    t.set_bits(round_half<std::round_toward_neg_infinity>(arg.get_bits()));
    return t;
}

inline half ceil(half arg) {
    half t;
    t.set_bits(round_half<std::round_toward_infinity>(arg.get_bits()));
    return t;
}

inline half trunc(half arg) {
    half t;
    t.set_bits(round_half<std::round_toward_zero>(arg.get_bits()));
    return t;
}

inline half round(half arg) {
    half t;
    t.set_bits(round_half_up(arg.get_bits()));
    return t;
}

inline long lround(half arg) {
    return half2int_up<long>(arg.get_bits());
}

struct half_round_style {
    static const std::float_round_style round_style = (std::float_round_style)(HALF_ROUND_STYLE);
};

inline half rint(half arg) {
    half t;
    t.set_bits(round_half<half_round_style::round_style>(arg.get_bits()));
    return t;
}

inline long lrint(half arg) {
    return half2int<half_round_style::round_style, long>(arg.get_bits());
}

#if HALF_ENABLE_CPP11_LONG_LONG
inline long long llround(half arg) {
    return half2int_up<long long>(arg.get_bits());
}

inline long long llrint(half arg) {
    return half2int<half_round_style::round_style, long long>(arg.get_bits());
}
#endif

#ifdef HLS_NO_XIL_FPO_LIB
inline float sqrt(half arg) {
    return std::sqrt(arg);
}
#else
inline half sqrt(half arg) {
    return half::math_function_1arg(xip_fpo_sqrt, arg);
}
#endif
//-------------------------------------------------------------------------------------------------//
inline bool isunordered(half x, half y) {
    return isnan(x) || isnan(y);
}

#ifdef HLS_NO_XIL_FPO_LIB
inline bool isequal(half x, half y) {
    return (x.get_bits() == y.get_bits() || !((x.get_bits() | y.get_bits()) & 0x7FFF)) && !isnan(x);
}
#else
template <typename T1, typename T2>
inline bool isequal(T1 x, T2 y) {
    return half::binary_operator_compare(xip_fpo_equal, x, y);
}
inline bool isequal(float x, half y) {
    return HLS_FPO_EQUALF(x, y);
}
inline bool isequal(half x, float y) {
    return HLS_FPO_EQUALF(x, y);
}
inline bool isequal(double x, half y) {
    return HLS_FPO_EQUAL(x, y);
}
inline bool isequal(half x, double y) {
    return HLS_FPO_EQUAL(x, y);
}
#endif

#ifdef HLS_NO_XIL_FPO_LIB
inline bool isnotequal(half x, half y) {
    return (x.get_bits() != y.get_bits() && ((x.get_bits() | y.get_bits()) & 0x7FFF)) || isnan(x);
}
#else
template <typename T1, typename T2>
inline bool isnotequal(T1 x, T2 y) {
    return half::binary_operator_compare(xip_fpo_notequal, x, y);
}
inline bool isnotequal(float x, half y) {
    return HLS_FPO_NOTEQUALF(x, y);
}
inline bool isnotequal(half x, float y) {
    return HLS_FPO_NOTEQUALF(x, y);
}
inline bool isnotequal(double x, half y) {
    return HLS_FPO_NOTEQUAL(x, y);
}
inline bool isnotequal(half x, double y) {
    return HLS_FPO_NOTEQUAL(x, y);
}
#endif

#ifdef HLS_NO_XIL_FPO_LIB
inline bool isgreater(half x, half y) {
    return !isnan(x) && !isnan(y) &&
           ((signbit(x) ? (static_cast<int>(0x8000) - x.get_bits()) : static_cast<int>(x.get_bits())) >
            (signbit(y) ? (static_cast<int>(0x8000) - y.get_bits()) : static_cast<int>(y.get_bits())));
}
#else
template <typename T1, typename T2>
inline bool isgreater(T1 x, T2 y) {
    return half::binary_operator_compare(xip_fpo_greater, x, y);
}
inline bool isgreater(float x, half y) {
    return HLS_FPO_GREATERF(x, y);
}
inline bool isgreater(half x, float y) {
    return HLS_FPO_GREATERF(x, y);
}
inline bool isgreater(double x, half y) {
    return HLS_FPO_GREATER(x, y);
}
inline bool isgreater(half x, double y) {
    return HLS_FPO_GREATER(x, y);
}
#endif

#ifdef HLS_NO_XIL_FPO_LIB
inline bool isgreaterequal(half x, half y) {
    return !isnan(x) && !isnan(y) &&
           ((signbit(x) ? (static_cast<int>(0x8000) - x.get_bits()) : static_cast<int>(x.get_bits())) >=
            (signbit(y) ? (static_cast<int>(0x8000) - y.get_bits()) : static_cast<int>(y.get_bits())));
}
#else
template <typename T1, typename T2>
inline bool isgreaterequal(T1 x, T2 y) {
    return half::binary_operator_compare(xip_fpo_greaterequal, x, y);
}
inline bool isgreaterequal(float x, half y) {
    return HLS_FPO_GREATEREQUALF(x, y);
}
inline bool isgreaterequal(half x, float y) {
    return HLS_FPO_GREATEREQUALF(x, y);
}
inline bool isgreaterequal(double x, half y) {
    return HLS_FPO_GREATEREQUAL(x, y);
}
inline bool isgreaterequal(half x, double y) {
    return HLS_FPO_GREATEREQUAL(x, y);
}
#endif

#ifdef HLS_NO_XIL_FPO_LIB
inline bool isless(half x, half y) {
    return !isnan(x) && !isnan(y) &&
           ((signbit(x) ? (static_cast<int>(0x8000) - x.get_bits()) : static_cast<int>(x.get_bits())) <
            (signbit(y) ? (static_cast<int>(0x8000) - y.get_bits()) : static_cast<int>(y.get_bits())));
}
#else
template <typename T1, typename T2>
inline bool isless(T1 x, T2 y) {
    return half::binary_operator_compare(xip_fpo_less, x, y);
}
inline bool isless(float x, half y) {
    return HLS_FPO_LESSF(x, y);
}
inline bool isless(half x, float y) {
    return HLS_FPO_LESSF(x, y);
}
inline bool isless(double x, half y) {
    return HLS_FPO_LESS(x, y);
}
inline bool isless(half x, double y) {
    return HLS_FPO_LESS(x, y);
}
#endif

#ifdef HLS_NO_XIL_FPO_LIB
static bool islessequal(half x, half y) {
    return !isnan(x) && !isnan(y) &&
           ((signbit(x) ? (static_cast<int>(0x8000) - x.get_bits()) : static_cast<int>(x.get_bits())) <=
            (signbit(y) ? (static_cast<int>(0x8000) - y.get_bits()) : static_cast<int>(y.get_bits())));
}
#else
template <typename T1, typename T2>
inline bool islessequal(T1 x, T2 y) {
    return half::binary_operator_compare(xip_fpo_lessequal, x, y);
}
inline bool islessequal(float x, half y) {
    return HLS_FPO_LESSEQUALF(x, y);
}
inline bool islessequal(half x, float y) {
    return HLS_FPO_LESSEQUALF(x, y);
}
inline bool islessequal(double x, half y) {
    return HLS_FPO_LESSEQUAL(x, y);
}
inline bool islessequal(half x, double y) {
    return HLS_FPO_LESSEQUAL(x, y);
}
#endif

inline bool islessgreater(half x, half y) {
    if (isnan(x) || isnan(y)) return false;
    return detail::isless(x, y) || detail::isgreater(x, y);
}


} // namespace detail
using detail::fpclassify;
using detail::isfinite;
using detail::isgreater;
using detail::isgreaterequal;
using detail::isinf;
using detail::isless;
using detail::islessequal;
using detail::islessgreater;
using detail::isnan;
using detail::isnormal;
using detail::isunordered;
using detail::signbit;

#endif // __SYNTHESIS__

#endif // __HLS_HALF_UTILS_H__
