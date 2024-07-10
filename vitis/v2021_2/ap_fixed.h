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

#ifndef __AP_FIXED_H__
#define __AP_FIXED_H__

#include "ap_common.h"
#include "ap_fixed_base.h"
#include "ap_fixed_ref.h"

//---------------------------------------------------------------

/// Signed Arbitrary Precision Fixed-Point Type.
// default for _AP_Q, _AP_O and _AP_N set in ap_decl.h
template <int _AP_W, int _AP_I, ap_q_mode _AP_Q, ap_o_mode _AP_O, int _AP_N>
struct ap_fixed : ap_fixed_base<_AP_W, _AP_I, true, _AP_Q, _AP_O, _AP_N> {
  typedef ap_fixed_base<_AP_W, _AP_I, true, _AP_Q, _AP_O, _AP_N> Base;
  // Constructor
  /// default ctor
  INLINE ap_fixed() : Base() {}

  /// copy ctor from ap_fixed_base.
  template <int _AP_W2, int _AP_I2, bool _AP_S2, ap_q_mode _AP_Q2,
            ap_o_mode _AP_O2, int _AP_N2>
  INLINE ap_fixed(const ap_fixed_base<_AP_W2, _AP_I2, _AP_S2, _AP_Q2,
                                      _AP_O2, _AP_N2>& op)
      : Base(op) {}

  template <int _AP_W2, int _AP_I2, bool _AP_S2, ap_q_mode _AP_Q2,
            ap_o_mode _AP_O2, int _AP_N2>
  INLINE ap_fixed(const volatile ap_fixed_base<_AP_W2, _AP_I2, _AP_S2, _AP_Q2,
                                               _AP_O2, _AP_N2>& op)
      : Base(op) {}

  //// from ap_fixed
  //template <int _AP_W2, int _AP_I2, ap_q_mode _AP_Q2, ap_o_mode _AP_O2,
  //          int _AP_N2>
  //INLINE ap_fixed(
  //    const ap_fixed<_AP_W2, _AP_I2, _AP_Q2, _AP_O2, _AP_N2>& op)
  //    : Base(ap_fixed_base<_AP_W2, _AP_I2, true, _AP_Q2, _AP_O2, _AP_N2>(op)) {}

  //template <int _AP_W2, int _AP_I2, ap_q_mode _AP_Q2, ap_o_mode _AP_O2,
  //          int _AP_N2>
  //INLINE ap_fixed(
  //    const volatile ap_fixed<_AP_W2, _AP_I2, _AP_Q2, _AP_O2, _AP_N2>& op)
  //    : Base(ap_fixed_base<_AP_W2, _AP_I2, true, _AP_Q2, _AP_O2, _AP_N2>(op)) {}

  //// from ap_ufixed.
  //template <int _AP_W2, int _AP_I2, ap_q_mode _AP_Q2, ap_o_mode _AP_O2,
  //          int _AP_N2>
  //INLINE ap_fixed(
  //    const ap_ufixed<_AP_W2, _AP_I2, _AP_Q2, _AP_O2, _AP_N2>& op)
  //    : Base(ap_fixed_base<_AP_W2, _AP_I2, false, _AP_Q2, _AP_O2, _AP_N2>(op)) {
  //}

  //template <int _AP_W2, int _AP_I2, ap_q_mode _AP_Q2, ap_o_mode _AP_O2,
  //          int _AP_N2>
  //INLINE ap_fixed(
  //    const volatile ap_ufixed<_AP_W2, _AP_I2, _AP_Q2, _AP_O2, _AP_N2>& op)
  //    : Base(ap_fixed_base<_AP_W2, _AP_I2, false, _AP_Q2, _AP_O2, _AP_N2>(op)) {
  //}

  /// copy ctor from ap_int_base.
  template <int _AP_W2, bool _AP_S2>
  INLINE ap_fixed(const ap_int_base<_AP_W2, _AP_S2>& op) : Base(op) {}

  template <int _AP_W2, bool _AP_S2>
  INLINE ap_fixed(const volatile ap_int_base<_AP_W2, _AP_S2>& op) : Base(op) {}

#ifdef __SYNTHESIS__
#if ((__clang_major__ != 3) || (__clang_minor__ != 1))
  /// ctor from raw val
  INLINE ap_fixed(unsigned V __attribute__((bitwidth(_AP_W))), bool raw) {
    Base::V = V;
    _AP_UNUSED_PARAM(raw);
  }
#endif
#endif

  //// from ap_int.
  //template <int _AP_W2>
  //INLINE ap_fixed(const ap_int<_AP_W2>& op)
  //    : Base(ap_int_base<_AP_W2, true>(op)) {}

  //template <int _AP_W2>
  //INLINE ap_fixed(const volatile ap_int<_AP_W2>& op)
  //    : Base(ap_int_base<_AP_W2, true>(op)) {}

  //// from ap_uint.
  //template <int _AP_W2>
  //INLINE ap_fixed(const ap_uint<_AP_W2>& op)
  //    : Base(ap_int_base<_AP_W2, false>(op)) {}

  //template <int _AP_W2>
  //INLINE ap_fixed(const volatile ap_uint<_AP_W2>& op)
  //    : Base(ap_int_base<_AP_W2, false>(op)) {}

  // from ap_bit_ref.
  template <int _AP_W2, bool _AP_S2>
  INLINE ap_fixed(const ap_bit_ref<_AP_W2, _AP_S2>& op) : Base(op) {}

  // from ap_range_ref.
  template <int _AP_W2, bool _AP_S2>
  INLINE ap_fixed(const ap_range_ref<_AP_W2, _AP_S2>& op) : Base(op) {}

  // from ap_concat_ref.
  template <int _AP_W2, typename _AP_T2, int _AP_W3, typename _AP_T3>
  INLINE ap_fixed(const ap_concat_ref<_AP_W2, _AP_T2, _AP_W3, _AP_T3>& op)
      : Base(op) {}

  // from af_bit_ref.
  template <int _AP_W2, int _AP_I2, bool _AP_S2, ap_q_mode _AP_Q2,
            ap_o_mode _AP_O2, int _AP_N2>
  INLINE ap_fixed(
      const af_bit_ref<_AP_W2, _AP_I2, _AP_S2, _AP_Q2, _AP_O2, _AP_N2>& op)
      : Base(op) {}

  // from af_range_ref.
  template <int _AP_W2, int _AP_I2, bool _AP_S2, ap_q_mode _AP_Q2,
            ap_o_mode _AP_O2, int _AP_N2>
  INLINE ap_fixed(
      const af_range_ref<_AP_W2, _AP_I2, _AP_S2, _AP_Q2, _AP_O2, _AP_N2>& op)
      : Base(op) {}

// from c types.
#define CTOR(TYPE) \
  INLINE ap_fixed(TYPE v) : Base(v) {}

  CTOR(bool)
  CTOR(char)
  CTOR(signed char)
  CTOR(unsigned char)
  CTOR(short)
  CTOR(unsigned short)
  CTOR(int)
  CTOR(unsigned int)
  CTOR(long)
  CTOR(unsigned long)
  CTOR(ap_slong)
  CTOR(ap_ulong)
  CTOR(half)
  CTOR(float)
  CTOR(double)
#undef CTOR

  INLINE ap_fixed(const char* s) : Base(s) {}

  INLINE ap_fixed(const char* s, signed char rd) : Base(s, rd) {}

  // Assignment
  // The assignment operator is technically inherited; however, it is always
  // hidden by an explicitly or implicitly defined assignment operator for the
  // derived class.
  /* XXX ctor will be used when right is not of proper type. */
#ifndef _MSC_VER
  ap_fixed &
  operator=(const ap_fixed<_AP_W, _AP_I, _AP_Q, _AP_O, _AP_N> &op) = default;
#else
  INLINE ap_fixed& operator=(
      const ap_fixed<_AP_W, _AP_I, _AP_Q, _AP_O, _AP_N>& op) {
      Base::V = op.V;
      return *this;
  }
#endif

  INLINE void operator=(
      const ap_fixed<_AP_W, _AP_I, _AP_Q, _AP_O, _AP_N>& op) volatile {
    Base::V = op.V;
  }

  INLINE ap_fixed& operator=(
      const volatile ap_fixed<_AP_W, _AP_I, _AP_Q, _AP_O, _AP_N>& op) {
    Base::V = op.V;
    return *this;
  }

  INLINE void operator=(
      const volatile ap_fixed<_AP_W, _AP_I, _AP_Q, _AP_O, _AP_N>& op) volatile {
    Base::V = op.V;
  }
}; // struct ap_fixed.

//-------------------------------------------------------------------

// Unsigned Arbitrary Precision Fixed-Point Type.
// default for _AP_Q, _AP_O and _AP_N set in ap_decl.h
template <int _AP_W, int _AP_I, ap_q_mode _AP_Q, ap_o_mode _AP_O, int _AP_N>
struct ap_ufixed : ap_fixed_base<_AP_W, _AP_I, false, _AP_Q, _AP_O, _AP_N> {
  typedef ap_fixed_base<_AP_W, _AP_I, false, _AP_Q, _AP_O, _AP_N> Base;
  // Constructor
  /// default ctor
  INLINE ap_ufixed() : Base() {}

  /// copy ctor from ap_fixed_base
  template <int _AP_W2, int _AP_I2, bool _AP_S2, ap_q_mode _AP_Q2,
            ap_o_mode _AP_O2, int _AP_N2>
  INLINE ap_ufixed(const ap_fixed_base<_AP_W2, _AP_I2, _AP_S2, _AP_Q2,
                                       _AP_O2, _AP_N2>& op)
      : Base(op) {}

  /// copy ctor from ap_fixed_base
  template <int _AP_W2, int _AP_I2, bool _AP_S2, ap_q_mode _AP_Q2,
            ap_o_mode _AP_O2, int _AP_N2>
  INLINE ap_ufixed(const volatile ap_fixed_base<_AP_W2, _AP_I2, _AP_S2, _AP_Q2,
                                                _AP_O2, _AP_N2>& op)
      : Base(op) {}

  //template <int _AP_W2, int _AP_I2, ap_q_mode _AP_Q2, ap_o_mode _AP_O2,
  //          int _AP_N2>
  //INLINE ap_ufixed(
  //    const ap_fixed<_AP_W2, _AP_I2, _AP_Q2, _AP_O2, _AP_N2>& op)
  //    : Base(ap_fixed_base<_AP_W2, _AP_I2, true, _AP_Q2, _AP_O2, _AP_N2>(op)) {}

  //template <int _AP_W2, int _AP_I2, ap_q_mode _AP_Q2, ap_o_mode _AP_O2,
  //          int _AP_N2>
  //INLINE ap_ufixed(
  //    const volatile ap_fixed<_AP_W2, _AP_I2, _AP_Q2, _AP_O2, _AP_N2>& op)
  //    : Base(ap_fixed_base<_AP_W2, _AP_I2, true, _AP_Q2, _AP_O2, _AP_N2>(op)) {}

  //template <int _AP_W2, int _AP_I2, ap_q_mode _AP_Q2, ap_o_mode _AP_O2,
  //          int _AP_N2>
  //INLINE ap_ufixed(
  //    const ap_ufixed<_AP_W2, _AP_I2, _AP_Q2, _AP_O2, _AP_N2>& op)
  //    : Base(ap_fixed_base<_AP_W2, _AP_I2, false, _AP_Q2, _AP_O2, _AP_N2>(op)) {
  //}

  //template <int _AP_W2, int _AP_I2, ap_q_mode _AP_Q2, ap_o_mode _AP_O2,
  //          int _AP_N2>
  //INLINE ap_ufixed(
  //    const volatile ap_ufixed<_AP_W2, _AP_I2, _AP_Q2, _AP_O2, _AP_N2>& op)
  //    : Base(ap_fixed_base<_AP_W2, _AP_I2, false, _AP_Q2, _AP_O2, _AP_N2>(op)) {
  //}

  /// copy ctor from ap_int_base.
  template <int _AP_W2, bool _AP_S2>
  INLINE ap_ufixed(const ap_int_base<_AP_W2, _AP_S2>& op) : Base(op) {}

  template <int _AP_W2, bool _AP_S2>
  INLINE ap_ufixed(const volatile ap_int_base<_AP_W2, _AP_S2>& op) : Base(op) {}

#ifdef __SYNTHESIS__
#if ((__clang_major__ != 3) || (__clang_minor__ != 1))
  /// ctor from  raw val
  INLINE ap_ufixed(unsigned V __attribute__((bitwidth(_AP_W))), bool raw) {
    Base::V = V;
    _AP_UNUSED_PARAM(raw);
  }
#endif
#endif

  //template <int _AP_W2>
  //INLINE ap_ufixed(const ap_int<_AP_W2>& op)
  //    : Base(ap_int_base<_AP_W2, true>(op)) {}

  //template <int _AP_W2>
  //INLINE ap_ufixed(const volatile ap_int<_AP_W2>& op)
  //    : Base(ap_int_base<_AP_W2, true>(op)) {}

  //template <int _AP_W2>
  //INLINE ap_ufixed(const ap_uint<_AP_W2>& op)
  //    : Base(ap_int_base<_AP_W2, false>(op)) {}

  //template <int _AP_W2>
  //INLINE ap_ufixed(const volatile ap_uint<_AP_W2>& op)
  //    : Base(ap_int_base<_AP_W2, false>(op)) {}

  template <int _AP_W2, bool _AP_S2>
  INLINE ap_ufixed(const ap_bit_ref<_AP_W2, _AP_S2>& op) : Base(op) {}

  template <int _AP_W2, bool _AP_S2>
  INLINE ap_ufixed(const ap_range_ref<_AP_W2, _AP_S2>& op) : Base(op) {}

  template <int _AP_W2, typename _AP_T2, int _AP_W3, typename _AP_T3>
  INLINE ap_ufixed(const ap_concat_ref<_AP_W2, _AP_T2, _AP_W3, _AP_T3>& op)
      : Base(op) {}

  template <int _AP_W2, int _AP_I2, bool _AP_S2, ap_q_mode _AP_Q2,
            ap_o_mode _AP_O2, int _AP_N2>
  INLINE ap_ufixed(
      const af_bit_ref<_AP_W2, _AP_I2, _AP_S2, _AP_Q2, _AP_O2, _AP_N2>& op)
      : Base(op) {}

  template <int _AP_W2, int _AP_I2, bool _AP_S2, ap_q_mode _AP_Q2,
            ap_o_mode _AP_O2, int _AP_N2>
  INLINE ap_ufixed(
      const af_range_ref<_AP_W2, _AP_I2, _AP_S2, _AP_Q2, _AP_O2, _AP_N2>& op)
      : Base(op) {}

#define CTOR(TYPE) \
  INLINE ap_ufixed(TYPE v) : Base(v) {}

  CTOR(bool)
  CTOR(char)
  CTOR(signed char)
  CTOR(unsigned char)
  CTOR(short)
  CTOR(unsigned short)
  CTOR(int)
  CTOR(unsigned int)
  CTOR(long)
  CTOR(unsigned long)
  CTOR(ap_slong)
  CTOR(ap_ulong)
  CTOR(half)
  CTOR(float)
  CTOR(double)
#undef CTOR

  INLINE ap_ufixed(const char* s) : Base(s) {}

  INLINE ap_ufixed(const char* s, signed char rd) : Base(s, rd) {}

  // Assignment
 #ifndef _MSC_VER
  ap_ufixed &
  operator=(const ap_ufixed<_AP_W, _AP_I, _AP_Q, _AP_O, _AP_N> &op) = default;
#else
  INLINE ap_ufixed& operator=(
      const ap_ufixed<_AP_W, _AP_I, _AP_Q, _AP_O, _AP_N>& op) {
      Base::V = op.V;
      return *this;
  }
#endif

  INLINE void operator=(
      const ap_ufixed<_AP_W, _AP_I, _AP_Q, _AP_O, _AP_N>& op) volatile {
    Base::V = op.V;
  }

  INLINE ap_ufixed& operator=(
      const volatile ap_ufixed<_AP_W, _AP_I, _AP_Q, _AP_O, _AP_N>& op) {
    Base::V = op.V;
    return *this;
  }

  INLINE void operator=(const volatile ap_ufixed<_AP_W, _AP_I, _AP_Q, _AP_O,
                                                 _AP_N>& op) volatile {
    Base::V = op.V;
  }
}; // struct ap_ufixed


#if !defined(__SYNTHESIS__) && (defined(SYSTEMC_H) || defined(SYSTEMC_INCLUDED))
// XXX sc_trace overload for ap_fixed is already included in
// "ap_sysc/ap_sc_extras.h", so do not define in synthesis.
template <int _AP_W, int _AP_I, ap_q_mode _AP_Q, ap_o_mode _AP_O, int _AP_N>
INLINE void sc_trace(sc_core::sc_trace_file* tf,
                     const ap_fixed<_AP_W, _AP_I, _AP_Q, _AP_O, _AP_N>& op,
                     const std::string& name) {
  tf->trace(sc_dt::sc_lv<_AP_W>(op.to_string(2).c_str()), name);
}

template <int _AP_W, int _AP_I, ap_q_mode _AP_Q, ap_o_mode _AP_O, int _AP_N>
INLINE void sc_trace(sc_core::sc_trace_file* tf,
                     const ap_ufixed<_AP_W, _AP_I, _AP_Q, _AP_O, _AP_N>& op,
                     const std::string& name) {
  tf->trace(sc_dt::sc_lv<_AP_W>(op.to_string(2).c_str()), name);
}
#endif // System C sim

// Specialization of std containers, so that std::complex<ap_fixed> can have its
// image part automatically zero-initialized when only real part is provided.
#include "ap_fixed_special.h"

#endif // ifndef __AP_FIXED_H__ else

// -*- cpp -*-
