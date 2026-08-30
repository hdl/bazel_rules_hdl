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

#ifndef __AP_COMMON_H__
#define __AP_COMMON_H__

// ----------------------------------------------------------------------

#include "ap_decl.h"

// Macro functions
#define AP_MAX(a, b) ((a) > (b) ? (a) : (b))
#define AP_MIN(a, b) ((a) < (b) ? (a) : (b))
#define AP_ABS(a) ((a) >= 0 ? (a) : -(a))

#ifndef AP_ASSERT
#ifndef __SYNTHESIS__
#include <assert.h>
#define AP_ASSERT(cond, msg) assert((cond) && (msg))
#else
#define AP_ASSERT(cond, msg)
#endif // ifndef __SYNTHESIS__
#endif // ifndef AP_ASSERT


#ifndef _AP_UNUSED_PARAM
 #define _AP_UNUSED_PARAM(x) (void)(x)
#endif

#ifndef __SYNTHESIS__
// for fprintf messages.
#include <stdio.h>
// for exit on error.
#include <stdlib.h>
#endif

#define AP_WARNING(OVERFLOW_TYPE, VALUE, AP, WIDTH)                            \
    std::cout << "WARNING: assign " << OVERFLOW_TYPE << " value "              \
        << VALUE << " to type " << AP << "<" << WIDTH << ">."                  \
        << std::endl;                                                          \
    std::cout << "Use gdb to diagnose into " << __FILE__ <<                    \
        ":" << __FUNCTION__ << ":" << __LINE__  << std::endl;

// same disable condition as assert.
#if !defined(__SYNTHESIS__) && !defined(NDEBUG)

#define _AP_DEBUG(cond, ...)                  \
  do {                                        \
    if ((cond)) {                             \
      fprintf(stderr, "DEBUG: " __VA_ARGS__); \
      fprintf(stderr, "\n");                  \
    }                                         \
  } while (0)
#define _AP_WARNING(cond, ...)                  \
  do {                                          \
    if ((cond)) {                               \
      fprintf(stderr, "WARNING: " __VA_ARGS__); \
      fprintf(stderr, "\n");                    \
    }                                           \
  } while (0)
#define _AP_ERROR(cond, ...)                  \
  do {                                        \
    if ((cond)) {                             \
      fprintf(stderr, "ERROR: " __VA_ARGS__); \
      fprintf(stderr, "\n");                  \
      abort();                                \
    }                                         \
  } while (0)

#else // if !defined(__SYNTHESIS__) && !defined(NDEBUG)

#define __AP_VOID_CAST static_cast<void>
#define _AP_DEBUG(cond, ...) (__AP_VOID_CAST(0))
#define _AP_WARNING(cond, ...) (__AP_VOID_CAST(0))
#define _AP_ERROR(cond, ...) (__AP_VOID_CAST(0))

#endif // if !defined(__SYNTHESIS__) && !defined(NDEBUG) else

// ----------------------------------------------------------------------

// Attribute only for synthesis
#ifdef __SYNTHESIS__
#define INLINE inline __attribute__((always_inline))
//#define INLINE inline __attribute__((noinline))
#else
#define INLINE inline
#endif

#define AP_WEAK
// __attribute__((weak))

#ifndef AP_INT_MAX_W
#define AP_INT_MAX_W 1024
#endif

#define BIT_WIDTH_UPPER_LIMIT (1 << 15)
#if AP_INT_MAX_W > BIT_WIDTH_UPPER_LIMIT
#error "Bitwidth exceeds 32768 (1 << 15), the maximum allowed value"
#endif

#define MAX_MODE(BITS) ((BITS + 1023) / 1024)

// ----------------------------------------------------------------------

// XXX apcc cannot handle global std::ios_base::Init() brought in by <iostream>
#ifndef AP_AUTOCC
#ifndef __SYNTHESIS__
// for overload operator<<
#include <iostream>
#endif
#endif // ifndef AP_AUTOCC

#ifndef __SYNTHESIS__
// for string format.
#include <sstream>
// for string.
#include <string>
#endif

// for detecting if char is signed.
enum { CHAR_IS_SIGNED = (char)-1 < 0 };

// TODO we have similar traits in x_hls_utils.h, should consider unify.
namespace _ap_type {
template <typename _Tp>
struct is_signed {
  static const bool value = _Tp(-1) < _Tp(1);
};

template <typename _Tp>
struct is_integral {
  static const bool value = false;
};
#define DEF_IS_INTEGRAL(CTYPE)      \
  template <>                       \
  struct is_integral<CTYPE> {       \
    static const bool value = true; \
  };
DEF_IS_INTEGRAL(bool)
DEF_IS_INTEGRAL(char)
DEF_IS_INTEGRAL(signed char)
DEF_IS_INTEGRAL(unsigned char)
DEF_IS_INTEGRAL(short)
DEF_IS_INTEGRAL(unsigned short)
DEF_IS_INTEGRAL(int)
DEF_IS_INTEGRAL(unsigned int)
DEF_IS_INTEGRAL(long)
DEF_IS_INTEGRAL(unsigned long)
DEF_IS_INTEGRAL(ap_slong)
DEF_IS_INTEGRAL(ap_ulong)
#undef DEF_IS_INTEGRAL

template <bool, typename _Tp = void>
struct enable_if {};
// partial specialization for true
template <typename _Tp>
struct enable_if<true, _Tp> {
  typedef _Tp type;
};

template <typename _Tp>
struct remove_const {
  typedef _Tp type;
};

template <typename _Tp>
struct remove_const<_Tp const> {
  typedef _Tp type;
};
} // namespace _ap_type

// ----------------------------------------------------------------------

// Define ssdm_int and _ssdm_op.
#ifdef __SYNTHESIS__

#if ((__clang_major__ == 3) && (__clang_minor__ == 1))

/* HECTOR is a tool for formal system-level to RTL equivalence checking.
 * https://www.research.ibm.com/haifa/conferences/hvc2008/present/CarlPixleyHVC08.pdf
 * we used to used Hector.h here instead of following ssdm_int definition,
 * but now it is deleted.
 */
template <int _AP_N, bool _AP_S>
struct ssdm_int;

#define AP_INT_BASE(_AP_N, mode)                                              \
  template <>                                                                 \
  struct ssdm_int<_AP_N + 1024 * mode, true> {                                \
    typedef int __attribute__((bitwidth(_AP_N + 1024 * mode))) DataType;      \
    int V __attribute__((bitwidth(_AP_N + 1024 * mode)));                     \
    INLINE ssdm_int<_AP_N + 1024 * mode, true>(){};                           \
  };                                                                          \
  template <>                                                                 \
  struct ssdm_int<_AP_N + 1024 * mode, false> {                               \
    typedef unsigned __attribute__((bitwidth(_AP_N + 1024 * mode))) DataType; \
    unsigned int V __attribute__((bitwidth(_AP_N + 1024 * mode)));            \
    INLINE ssdm_int<_AP_N + 1024 * mode, false>(){};                          \
  };

#if MAX_MODE(AP_INT_MAX_W) >= 1
#define HANDLE_BAT(TYPE, _AP_N) AP_INT_BASE(_AP_N, 0)
#define APINT_DEFINE_INT64
#include "etc/autopilot_dt.def"
#undef APINT_DEFINE_INT64
#undef HANDLE_BAT
#endif

#if MAX_MODE(AP_INT_MAX_W) >= 2
#define HANDLE_BAT(TYPE, _AP_N) AP_INT_BASE(_AP_N, 1)
#define APINT_DEFINE_INT64
#include "etc/autopilot_dt.def"
#undef APINT_DEFINE_INT64
#undef HANDLE_BAT
#endif

#if MAX_MODE(AP_INT_MAX_W) >= 3
#define HANDLE_BAT(TYPE, _AP_N) AP_INT_BASE(_AP_N, 2)
#define APINT_DEFINE_INT64
#include "etc/autopilot_dt.def"
#undef APINT_DEFINE_INT64
#undef HANDLE_BAT
#endif

#if MAX_MODE(AP_INT_MAX_W) >= 4
#define HANDLE_BAT(TYPE, _AP_N) AP_INT_BASE(_AP_N, 3)
#define APINT_DEFINE_INT64
#include "etc/autopilot_dt.def"
#undef APINT_DEFINE_INT64
#undef HANDLE_BAT
#endif

#if MAX_MODE(AP_INT_MAX_W) >= 5
#define HANDLE_BAT(TYPE, _AP_N) AP_INT_BASE(_AP_N, 4)
#define APINT_DEFINE_INT64
#include "etc/autopilot_dt.def"
#undef APINT_DEFINE_INT64
#undef HANDLE_BAT
#endif

#if MAX_MODE(AP_INT_MAX_W) >= 6
#define HANDLE_BAT(TYPE, _AP_N) AP_INT_BASE(_AP_N, 5)
#define APINT_DEFINE_INT64
#include "etc/autopilot_dt.def"
#undef APINT_DEFINE_INT64
#undef HANDLE_BAT
#endif

#if MAX_MODE(AP_INT_MAX_W) >= 7
#define HANDLE_BAT(TYPE, _AP_N) AP_INT_BASE(_AP_N, 6)
#define APINT_DEFINE_INT64
#include "etc/autopilot_dt.def"
#undef APINT_DEFINE_INT64
#undef HANDLE_BAT
#endif

#if MAX_MODE(AP_INT_MAX_W) >= 8
#define HANDLE_BAT(TYPE, _AP_N) AP_INT_BASE(_AP_N, 7)
#define APINT_DEFINE_INT64
#include "etc/autopilot_dt.def"
#undef APINT_DEFINE_INT64
#undef HANDLE_BAT
#endif

#if MAX_MODE(AP_INT_MAX_W) >= 9
#define HANDLE_BAT(TYPE, _AP_N) AP_INT_BASE(_AP_N, 8)
#define APINT_DEFINE_INT64
#include "etc/autopilot_dt.def"
#undef APINT_DEFINE_INT64
#undef HANDLE_BAT
#endif

#if MAX_MODE(AP_INT_MAX_W) >= 10
#define HANDLE_BAT(TYPE, _AP_N) AP_INT_BASE(_AP_N, 9)
#define APINT_DEFINE_INT64
#include "etc/autopilot_dt.def"
#undef APINT_DEFINE_INT64
#undef HANDLE_BAT
#endif

#if MAX_MODE(AP_INT_MAX_W) >= 11
#define HANDLE_BAT(TYPE, _AP_N) AP_INT_BASE(_AP_N, 10)
#define APINT_DEFINE_INT64
#include "etc/autopilot_dt.def"
#undef APINT_DEFINE_INT64
#undef HANDLE_BAT
#endif

#if MAX_MODE(AP_INT_MAX_W) >= 12
#define HANDLE_BAT(TYPE, _AP_N) AP_INT_BASE(_AP_N, 11)
#define APINT_DEFINE_INT64
#include "etc/autopilot_dt.def"
#undef APINT_DEFINE_INT64
#undef HANDLE_BAT
#endif

#if MAX_MODE(AP_INT_MAX_W) >= 13
#define HANDLE_BAT(TYPE, _AP_N) AP_INT_BASE(_AP_N, 12)
#define APINT_DEFINE_INT64
#include "etc/autopilot_dt.def"
#undef APINT_DEFINE_INT64
#undef HANDLE_BAT
#endif

#if MAX_MODE(AP_INT_MAX_W) >= 14
#define HANDLE_BAT(TYPE, _AP_N) AP_INT_BASE(_AP_N, 13)
#define APINT_DEFINE_INT64
#include "etc/autopilot_dt.def"
#undef APINT_DEFINE_INT64
#undef HANDLE_BAT
#endif

#if MAX_MODE(AP_INT_MAX_W) >= 15
#define HANDLE_BAT(TYPE, _AP_N) AP_INT_BASE(_AP_N, 14)
#define APINT_DEFINE_INT64
#include "etc/autopilot_dt.def"
#undef APINT_DEFINE_INT64
#undef HANDLE_BAT
#endif

#if MAX_MODE(AP_INT_MAX_W) >= 16
#define HANDLE_BAT(TYPE, _AP_N) AP_INT_BASE(_AP_N, 15)
#define APINT_DEFINE_INT64
#include "etc/autopilot_dt.def"
#undef APINT_DEFINE_INT64
#undef HANDLE_BAT
#endif

#if MAX_MODE(AP_INT_MAX_W) >= 17
#define HANDLE_BAT(TYPE, _AP_N) AP_INT_BASE(_AP_N, 16)
#define APINT_DEFINE_INT64
#include "etc/autopilot_dt.def"
#undef APINT_DEFINE_INT64
#undef HANDLE_BAT
#endif

#if MAX_MODE(AP_INT_MAX_W) >= 18
#define HANDLE_BAT(TYPE, _AP_N) AP_INT_BASE(_AP_N, 17)
#define APINT_DEFINE_INT64
#include "etc/autopilot_dt.def"
#undef APINT_DEFINE_INT64
#undef HANDLE_BAT
#endif

#if MAX_MODE(AP_INT_MAX_W) >= 19
#define HANDLE_BAT(TYPE, _AP_N) AP_INT_BASE(_AP_N, 18)
#define APINT_DEFINE_INT64
#include "etc/autopilot_dt.def"
#undef APINT_DEFINE_INT64
#undef HANDLE_BAT
#endif

#if MAX_MODE(AP_INT_MAX_W) >= 20
#define HANDLE_BAT(TYPE, _AP_N) AP_INT_BASE(_AP_N, 19)
#define APINT_DEFINE_INT64
#include "etc/autopilot_dt.def"
#undef APINT_DEFINE_INT64
#undef HANDLE_BAT
#endif

#if MAX_MODE(AP_INT_MAX_W) >= 21
#define HANDLE_BAT(TYPE, _AP_N) AP_INT_BASE(_AP_N, 20)
#define APINT_DEFINE_INT64
#include "etc/autopilot_dt.def"
#undef APINT_DEFINE_INT64
#undef HANDLE_BAT
#endif

#if MAX_MODE(AP_INT_MAX_W) >= 22
#define HANDLE_BAT(TYPE, _AP_N) AP_INT_BASE(_AP_N, 21)
#define APINT_DEFINE_INT64
#include "etc/autopilot_dt.def"
#undef APINT_DEFINE_INT64
#undef HANDLE_BAT
#endif

#if MAX_MODE(AP_INT_MAX_W) >= 23
#define HANDLE_BAT(TYPE, _AP_N) AP_INT_BASE(_AP_N, 22)
#define APINT_DEFINE_INT64
#include "etc/autopilot_dt.def"
#undef APINT_DEFINE_INT64
#undef HANDLE_BAT
#endif

#if MAX_MODE(AP_INT_MAX_W) >= 24
#define HANDLE_BAT(TYPE, _AP_N) AP_INT_BASE(_AP_N, 23)
#define APINT_DEFINE_INT64
#include "etc/autopilot_dt.def"
#undef APINT_DEFINE_INT64
#undef HANDLE_BAT
#endif

#if MAX_MODE(AP_INT_MAX_W) >= 25
#define HANDLE_BAT(TYPE, _AP_N) AP_INT_BASE(_AP_N, 24)
#define APINT_DEFINE_INT64
#include "etc/autopilot_dt.def"
#undef APINT_DEFINE_INT64
#undef HANDLE_BAT
#endif

#if MAX_MODE(AP_INT_MAX_W) >= 26
#define HANDLE_BAT(TYPE, _AP_N) AP_INT_BASE(_AP_N, 25)
#define APINT_DEFINE_INT64
#include "etc/autopilot_dt.def"
#undef APINT_DEFINE_INT64
#undef HANDLE_BAT
#endif

#if MAX_MODE(AP_INT_MAX_W) >= 27
#define HANDLE_BAT(TYPE, _AP_N) AP_INT_BASE(_AP_N, 26)
#define APINT_DEFINE_INT64
#include "etc/autopilot_dt.def"
#undef APINT_DEFINE_INT64
#undef HANDLE_BAT
#endif

#if MAX_MODE(AP_INT_MAX_W) >= 28
#define HANDLE_BAT(TYPE, _AP_N) AP_INT_BASE(_AP_N, 27)
#define APINT_DEFINE_INT64
#include "etc/autopilot_dt.def"
#undef APINT_DEFINE_INT64
#undef HANDLE_BAT
#endif

#if MAX_MODE(AP_INT_MAX_W) >= 29
#define HANDLE_BAT(TYPE, _AP_N) AP_INT_BASE(_AP_N, 28)
#define APINT_DEFINE_INT64
#include "etc/autopilot_dt.def"
#undef APINT_DEFINE_INT64
#undef HANDLE_BAT
#endif

#if MAX_MODE(AP_INT_MAX_W) >= 30
#define HANDLE_BAT(TYPE, _AP_N) AP_INT_BASE(_AP_N, 29)
#define APINT_DEFINE_INT64
#include "etc/autopilot_dt.def"
#undef APINT_DEFINE_INT64
#undef HANDLE_BAT
#endif

#if MAX_MODE(AP_INT_MAX_W) >= 31
#define HANDLE_BAT(TYPE, _AP_N) AP_INT_BASE(_AP_N, 30)
#define APINT_DEFINE_INT64
#include "etc/autopilot_dt.def"
#undef APINT_DEFINE_INT64
#undef HANDLE_BAT
#endif

#if MAX_MODE(AP_INT_MAX_W) >= 32
#define HANDLE_BAT(TYPE, _AP_N) AP_INT_BASE(_AP_N, 31)
#define APINT_DEFINE_INT64
#include "etc/autopilot_dt.def"
#undef APINT_DEFINE_INT64
#undef HANDLE_BAT
#endif

#undef MAX_MODE
#undef AP_INT_BASE

#else // HLS clang of higher version than 3.1

template <int _AP_N, bool _AP_S>
struct ssdm_int;

template <int _AP_N>
struct ssdm_int<_AP_N, true> {
  typedef int __attribute__((bitwidth(_AP_N))) DataType;
  int V __attribute__((bitwidth(_AP_N)));
  INLINE ssdm_int<_AP_N, true>(){};
};

template <int _AP_N>
struct ssdm_int<_AP_N, false> {
  typedef unsigned __attribute__((bitwidth(_AP_N))) DataType;
  unsigned V __attribute__((bitwidth(_AP_N)));
  INLINE ssdm_int<_AP_N, false>(){};
};

#endif // clang 3.1 test

// FIXME typeof is an compiler extension.
// FIXME use ({}) to return value is GCC extension.

#define _ssdm_op_concat(Ret, X, Y)                               \
  ({                                                             \
    typeof(Ret) __Result__ = 0;                                  \
    typeof(X) __X2__ = X;                                        \
    typeof(Y) __Y2__ = Y;                                        \
    __builtin_bit_concat((void*)(&__Result__), (void*)(&__X2__), \
                         (void*)(&__Y2__));                      \
    __Result__;                                                  \
  })

#define _ssdm_op_get_bit(Val, Bit)                                   \
  ({                                                                 \
    typeof(Val) __Val2__ = Val;                                      \
    bool __Result__ = __builtin_bit_select((void*)(&__Val2__), Bit); \
    __Result__;                                                      \
  })

#define _ssdm_op_set_bit(Val, Bit, Repl)                               \
  ({                                                                   \
    typename _ap_type::remove_const<typeof(Val)>::type __Result__ = 0; \
    typeof(Val) __Val2__ = Val;                                        \
    typeof(Repl) __Repl2__ = !!Repl;                                   \
    __builtin_bit_part_set((void*)(&__Result__), (void*)(&__Val2__),   \
                           (void*)(&__Repl2__), Bit, Bit);             \
    __Result__;                                                        \
  })

#define _ssdm_op_get_range(Val, Lo, Hi)                                     \
  ({                                                                        \
    typename _ap_type::remove_const<typeof(Val)>::type __Result__ = 0;      \
    typeof(Val) __Val2__ = Val;                                             \
    __builtin_bit_part_select((void*)(&__Result__), (void*)(&__Val2__), Lo, \
                              Hi);                                          \
    __Result__;                                                             \
  })

#define _ssdm_op_set_range(Val, Lo, Hi, Repl)                          \
  ({                                                                   \
    typename _ap_type::remove_const<typeof(Val)>::type __Result__ = 0; \
    typeof(Val) __Val2__ = Val;                                        \
    typeof(Repl) __Repl2__ = Repl;                                     \
    __builtin_bit_part_set((void*)(&__Result__), (void*)(&__Val2__),   \
                           (void*)(&__Repl2__), Lo, Hi);               \
    __Result__;                                                        \
  })

#include "etc/autopilot_ssdm_bits.h"

extern "C" void _ssdm_string2bits(...);

#endif // ifdef __SYNTHESIS__

#ifndef NON_C99STRING
#define _AP_C99 true
#else
#define _AP_C99 false
#endif

static inline unsigned char guess_radix(const char* s) {
  unsigned char rd = 10; ///< default radix
  const char* p = s;
  // skip neg sign if it exists
  if (p[0] == '-' || p[0] == '+') ++p;
  // guess based on following two bits.
  if (p[0] == '0') {
    if (p[1] == 'b' || p[1] == 'B') {
      rd = 2;
    } else if (p[1] == 'o' || p[1] == 'O') {
      rd = 8;
    } else if (p[1] == 'x' || p[1] == 'X') {
      rd = 16;
    } else if (p[1] == 'd' || p[1] == 'D') {
      rd = 10;
    }
  }
  return rd;
}

// ----------------------------------------------------------------------

// Forward declaration of all AP types.
// Before ap_private definition.
#ifdef __SYNTHESIS__
#define _HLS_HALF_DEFINED_
typedef __fp16 half;
#else
class half;
#endif

// FIXME previously, ap_int_syn.h includes hls_half.h, which includes cmath.h
// even during synthesis. Some test cases are spoiled...
#ifdef __cplusplus
#ifndef __SYNTHESIS__
#include <cmath>
#endif
#endif

// ----------------------------------------------------------------------

// Basic integral struct upon which ap_int and ap_fixed are defined.
#ifdef __SYNTHESIS__
// Use ssdm_int, a compiler dependent, attribute constrained integeral type as
// basic data type.
#define _AP_ROOT_TYPE ssdm_int
// Basic ops.
#define _AP_ROOT_op_concat(Ret, X, Y) _ssdm_op_concat(Ret, X, Y)
#define _AP_ROOT_op_get_bit(Val, Bit) _ssdm_op_get_bit(Val, Bit)
#define _AP_ROOT_op_set_bit(Val, Bit, Repl) _ssdm_op_set_bit(Val, Bit, Repl)
#define _AP_ROOT_op_get_range(Val, Lo, Hi) _ssdm_op_get_range(Val, Lo, Hi)
#define _AP_ROOT_op_set_range(Val, Lo, Hi, Repl) \
  _ssdm_op_set_range(Val, Lo, Hi, Repl)
#define _AP_ROOT_op_reduce(Op, Val) _ssdm_op_reduce(Op, Val)
#else // ifdef __SYNTHESIS__
// Use ap_private for compiler-independent basic data type
template <int _AP_W, bool _AP_S, bool _AP_C = _AP_W <= 64>
class ap_private;
/// model ssdm_int in standard C++ for simulation.
template <int _AP_W, bool _AP_S>
struct ssdm_int_sim {
  /// integral type with template-specified width and signedness.
  typedef ap_private<_AP_W, _AP_S> DataType;
  ap_private<_AP_W, _AP_S> V;
  ssdm_int_sim() {}
};
#define _AP_ROOT_TYPE ssdm_int_sim
// private's ref uses _AP_ROOT_TYPE.
#include "etc/ap_private.h"
// XXX The C-sim model cannot use GCC-extension
// Basic ops. Ret and Val are ap_private.
template <typename _Tp1, typename _Tp2, typename _Tp3>
inline _Tp1 _AP_ROOT_op_concat(const _Tp1& Ret, const _Tp2& X, const _Tp3& Y) {
  _Tp1 r = (X).operator,(Y);
  return r;
}
#define _AP_ROOT_op_get_bit(Val, Bit) (Val).get_bit((Bit))
template <typename _Tp1, typename _Tp2, typename _Tp3>
inline _Tp1& _AP_ROOT_op_set_bit(_Tp1& Val, const _Tp2& Bit, const _Tp3& Repl) {
  (Val).set_bit((Bit), (Repl));
  return Val;
}
// notice the order of high and low index is different in ssdm call and
// ap_private.range()...
#define _AP_ROOT_op_get_range(Val, Lo, Hi) (Val).range((Hi), (Lo))
template <typename _Tp1, typename _Tp2, typename _Tp3, typename _Tp4>
inline _Tp1& _AP_ROOT_op_set_range(_Tp1& Val, const _Tp2& Lo, const _Tp3& Hi,
                                   const _Tp4& Repl) {
  (Val).range((Hi), (Lo)) = Repl;
  return (Val);
}
#define _AP_ROOT_op_and_reduce(Val) (Val).and_reduce()
#define _AP_ROOT_op_nand_reduce(Val) (Val).nand_reduce()
#define _AP_ROOT_op_or_reduce(Val) (Val).or_reduce()
#define _AP_ROOT_op_xor_reduce(Val) (Val).xor_reduce()
// ## is the concatenation in preprocessor:
#define _AP_ROOT_op_reduce(Op, Val) _AP_ROOT_op_##Op##_reduce(Val)
#endif // ifdef __SYNTHESIS__ else

// ----------------------------------------------------------------------

// Constants for half, single, double pricision floating points
#define HALF_MAN 10
#define FLOAT_MAN 23
#define DOUBLE_MAN 52

#define HALF_EXP 5
#define FLOAT_EXP 8
#define DOUBLE_EXP 11

#define BIAS(e) ((1L << (e - 1L)) - 1L)
#define HALF_BIAS BIAS(HALF_EXP)
#define FLOAT_BIAS BIAS(FLOAT_EXP)
#define DOUBLE_BIAS BIAS(DOUBLE_EXP)

#define APFX_IEEE_DOUBLE_E_MAX DOUBLE_BIAS
#define APFX_IEEE_DOUBLE_E_MIN (-DOUBLE_BIAS + 1)

INLINE ap_ulong doubleToRawBits(double pf) {
  union {
    ap_ulong __L;
    double __D;
  } LD;
  LD.__D = pf;
  return LD.__L;
}

INLINE unsigned int floatToRawBits(float pf) {
  union {
    unsigned int __L;
    float __D;
  } LD;
  LD.__D = pf;
  return LD.__L;
}

INLINE unsigned short halfToRawBits(half pf) {
#ifdef __SYNTHESIS__
  union {
    unsigned short __L;
    half __D;
  } LD;
  LD.__D = pf;
  return LD.__L;
#else
  return pf.get_bits();
#endif
}

// usigned long long is at least 64-bit
INLINE double rawBitsToDouble(ap_ulong pi) {
  union {
    ap_ulong __L;
    double __D;
  } LD;
  LD.__L = pi;
  return LD.__D;
}

// long is at least 32-bit
INLINE float rawBitsToFloat(unsigned long pi) {
  union {
    unsigned int __L;
    float __D;
  } LD;
  LD.__L = pi;
  return LD.__D;
}

// short is at least 16-bit
INLINE half rawBitsToHalf(unsigned short pi) {
#ifdef __SYNTHESIS__
  union {
    unsigned short __L;
    half __D;
  } LD;
  LD.__L = pi;
  return LD.__D;
#else
  // sim model of half has a non-trivial constructor
  half __D;
  __D.set_bits(pi);
  return __D;
#endif
}

#endif // ifndef __AP_COMMON_H__ else

// -*- cpp -*-
// vim: fdm=marker:foldmarker=#if,#endif:nofoldenable


