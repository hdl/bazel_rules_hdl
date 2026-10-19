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

#ifndef __AP_FIXED_REF_H__
#define __AP_FIXED_REF_H__

#ifndef __AP_FIXED_H__
// TODO make this an error
#pragma message \
    "Only ap_fixed.h and ap_int.h can be included directly in user code."
#endif

#ifndef __cplusplus
#error "C++ is required to include this header file"

#else
#ifndef __SYNTHESIS__
#include <iostream>
#endif
/// Proxy class, which allows bit selection  to be used as both rvalue (for
/// reading) and lvalue (for writing)
template <int _AP_W, int _AP_I, bool _AP_S, ap_q_mode _AP_Q, ap_o_mode _AP_O,
          int _AP_N>
struct af_bit_ref {
#ifdef _MSC_VER
#pragma warning(disable : 4521 4522)
#endif
  typedef ap_fixed_base<_AP_W, _AP_I, _AP_S, _AP_Q, _AP_O, _AP_N> ref_type;
  ref_type& d_bv;
  int d_index;

 public:
  INLINE af_bit_ref(
      const af_bit_ref<_AP_W, _AP_I, _AP_S, _AP_Q, _AP_O, _AP_N>& ref)
      : d_bv(ref.d_bv), d_index(ref.d_index) {
#ifndef __SYNTHESIS__
    _AP_WARNING(d_index < 0, "Index of bit vector  (%d) cannot be negative.",
                d_index);
    _AP_WARNING(d_index >= _AP_W, "Index of bit vector (%d) out of range (%d).",
                d_index, _AP_W);
#endif
  }

  INLINE af_bit_ref(ref_type* bv, int index = 0) : d_bv(*bv), d_index(index) {}

  INLINE af_bit_ref(const ref_type* bv, int index = 0)
      : d_bv(*const_cast<ref_type*>(bv)), d_index(index) {}

  /// convert operators.
  INLINE operator bool() const { return _AP_ROOT_op_get_bit(d_bv.V, d_index); }

  /// @name assign operators
  //  @{
  INLINE af_bit_ref& operator=(bool val) {
    d_bv.V = _AP_ROOT_op_set_bit(d_bv.V, d_index, val);
    return *this;
  }

  // Be explicit to prevent it from being deleted, as field d_bv
  // is of reference type.
  INLINE af_bit_ref& operator=(const af_bit_ref& val) {
    return operator=(bool(val));
  }

  template <int _AP_W2, int _AP_I2, bool _AP_S2, ap_q_mode _AP_Q2,
            ap_o_mode _AP_O2, int _AP_N2>
  INLINE af_bit_ref& operator=(
      const af_bit_ref<_AP_W2, _AP_I2, _AP_S2, _AP_Q2, _AP_O2, _AP_N2>& val) {
    return operator=(bool(val));
  }

  template <int _AP_W2, bool _AP_S2>
  INLINE af_bit_ref& operator=(const ap_bit_ref<_AP_W2, _AP_S2>& val) {
    return operator=(bool(val));
  }

  template <int _AP_W2, bool _AP_S2>
  INLINE af_bit_ref& operator=(const ap_int_base<_AP_W2, _AP_S2>& val) {
    return operator=(val != 0);
  }

  template <int _AP_W2, bool _AP_S2>
  INLINE af_bit_ref& operator=(const ap_range_ref<_AP_W2, _AP_S2>& val) {
    return operator=(ap_int_base<_AP_W2, false>(val));
  }

  template <int _AP_W2, int _AP_I2, bool _AP_S2, ap_q_mode _AP_Q2,
            ap_o_mode _AP_O2, int _AP_N2>
  INLINE af_bit_ref& operator=(
      const af_range_ref<_AP_W2, _AP_I2, _AP_S2, _AP_Q2, _AP_O2, _AP_N2>& val) {
    return operator=(ap_int_base<_AP_W2, false>(val));
  }

  template <int _AP_W2, typename _AP_T2, int _AP_W3, typename _AP_T3>
  INLINE af_bit_ref& operator=(
      const ap_concat_ref<_AP_W2, _AP_T3, _AP_W3, _AP_T3>& val) {
    return operator=(ap_int_base<_AP_W2 + _AP_W3, false>(val));
  }
  //  @}

  /// @name concatenate operators
  //  @{
  template <int _AP_W2, int _AP_S2>
  INLINE ap_concat_ref<1, af_bit_ref, _AP_W2, ap_int_base<_AP_W2, _AP_S2> >
  operator,(ap_int_base<_AP_W2, _AP_S2> &op) {
    return ap_concat_ref<1, af_bit_ref, _AP_W2, ap_int_base<_AP_W2, _AP_S2> >(
        *this, op);
  }

  template <int _AP_W2, int _AP_S2>
  INLINE ap_concat_ref<1, af_bit_ref, 1, ap_bit_ref<_AP_W2, _AP_S2> > operator,(
      const ap_bit_ref<_AP_W2, _AP_S2> &op) {
    return ap_concat_ref<1, af_bit_ref, 1, ap_bit_ref<_AP_W2, _AP_S2> >(*this,
                                                                        op);
  }

  template <int _AP_W2, int _AP_S2>
  INLINE ap_concat_ref<1, af_bit_ref, _AP_W2, ap_range_ref<_AP_W2, _AP_S2> >
  operator,(const ap_range_ref<_AP_W2, _AP_S2> &op) {
    return ap_concat_ref<1, af_bit_ref, _AP_W2, ap_range_ref<_AP_W2, _AP_S2> >(
        *this, op);
  }

  template <int _AP_W2, typename _AP_T2, int _AP_W3, typename _AP_T3>
  INLINE ap_concat_ref<1, af_bit_ref, _AP_W2 + _AP_W3,
                       ap_concat_ref<_AP_W2, _AP_T2, _AP_W3, _AP_T3> >
  operator,(const ap_concat_ref<_AP_W2, _AP_T2, _AP_W3, _AP_T3> &op) {
    return ap_concat_ref<1, af_bit_ref, _AP_W2 + _AP_W3,
                         ap_concat_ref<_AP_W2, _AP_T2, _AP_W3, _AP_T3> >(*this,
                                                                         op);
  }

  template <int _AP_W2, int _AP_I2, bool _AP_S2, ap_q_mode _AP_Q2,
            ap_o_mode _AP_O2, int _AP_N2>
  INLINE ap_concat_ref<
      1, af_bit_ref, _AP_W2,
      af_range_ref<_AP_W2, _AP_I2, _AP_S2, _AP_Q2, _AP_O2, _AP_N2> >
  operator,(
      const af_range_ref<_AP_W2, _AP_I2, _AP_S2, _AP_Q2, _AP_O2, _AP_N2> &op) {
    return ap_concat_ref<
        1, af_bit_ref, _AP_W2,
        af_range_ref<_AP_W2, _AP_I2, _AP_S2, _AP_Q2, _AP_O2, _AP_N2> >(*this,
                                                                       op);
  }

  template <int _AP_W2, int _AP_I2, bool _AP_S2, ap_q_mode _AP_Q2,
            ap_o_mode _AP_O2, int _AP_N2>
  INLINE ap_concat_ref<1, af_bit_ref, 1, af_bit_ref<_AP_W2, _AP_I2, _AP_S2,
                                                    _AP_Q2, _AP_O2, _AP_N2> >
  operator,(
      const af_bit_ref<_AP_W2, _AP_I2, _AP_S2, _AP_Q2, _AP_O2, _AP_N2> &op) {
    return ap_concat_ref<1, af_bit_ref, 1, af_bit_ref<_AP_W2, _AP_I2, _AP_S2,
                                                      _AP_Q2, _AP_O2, _AP_N2> >(
        *this,
        const_cast<af_bit_ref<_AP_W2, _AP_I2, _AP_S2, _AP_Q2, _AP_O2, _AP_N2>&>(
            op));
  }
  //  @}

  /// @name comparison
  //  @{
  template <int _AP_W2, int _AP_I2, bool _AP_S2, ap_q_mode _AP_Q2,
            ap_o_mode _AP_O2, int _AP_N2>
  INLINE bool operator==(
      const af_bit_ref<_AP_W2, _AP_I2, _AP_S2, _AP_Q2, _AP_O2, _AP_N2>& op) {
    return get() == op.get();
  }

  template <int _AP_W2, int _AP_I2, bool _AP_S2, ap_q_mode _AP_Q2,
            ap_o_mode _AP_O2, int _AP_N2>
  INLINE bool operator!=(
      const af_bit_ref<_AP_W2, _AP_I2, _AP_S2, _AP_Q2, _AP_O2, _AP_N2>& op) {
    return get() != op.get();
  }
  //  @}

  INLINE bool operator~() const {
    bool bit = _AP_ROOT_op_get_bit(d_bv.V, d_index);
    return bit ? false : true;
  }

  INLINE bool get() const { return _AP_ROOT_op_get_bit(d_bv.V, d_index); }

  INLINE int length() const { return 1; }

#ifndef __SYNTHESIS__
  std::string to_string() const { return get() ? "1" : "0"; }
#else
  // XXX HLS will delete this in synthesis
  INLINE char* to_string() const { return 0; }
#endif
}; // struct af_bit_ref

// XXX apcc cannot handle global std::ios_base::Init() brought in by <iostream>
#ifndef AP_AUTOCC
#ifndef __SYNTHESIS__
template <int _AP_W, int _AP_I, bool _AP_S, ap_q_mode _AP_Q, ap_o_mode _AP_O,
          int _AP_N>
INLINE std::ostream& operator<<(
    std::ostream& os,
    const af_bit_ref<_AP_W, _AP_I, _AP_S, _AP_Q, _AP_O, _AP_N>& x) {
  os << x.to_string();
  return os;
}
#endif // ifndef __SYNTHESIS__
#endif // ifndef AP_AUTOCC

/// Range (slice) reference.
template <int _AP_W, int _AP_I, bool _AP_S, ap_q_mode _AP_Q, ap_o_mode _AP_O,
          int _AP_N>
struct af_range_ref {
#ifdef _MSC_VER
#pragma warning(disable : 4521 4522)
#endif
  typedef ap_fixed_base<_AP_W, _AP_I, _AP_S, _AP_Q, _AP_O, _AP_N> ref_type;
  ref_type& d_bv;
  int l_index;
  int h_index;

 public:
  /// copy ctor
  INLINE af_range_ref(
      const af_range_ref<_AP_W, _AP_I, _AP_S, _AP_Q, _AP_O, _AP_N>& ref)
      : d_bv(ref.d_bv), l_index(ref.l_index), h_index(ref.h_index) {}

  /// ctor from ap_fixed_base, higher and lower bound.
  /** if h is less than l, the bits selected will be returned in reverse order.
   */
  INLINE af_range_ref(ref_type* bv, int h, int l)
      : d_bv(*bv), l_index(l), h_index(h) {
#ifndef __SYNTHESIS__
    _AP_WARNING(h < 0 || l < 0,
                "Higher bound(%d) and lower(%d) bound cannot be negative.", h,
                l);
    _AP_WARNING(h >= _AP_W || l >= _AP_W,
                "Higher bound(%d) or lower(%d) bound out of range.", h, l);
    _AP_WARNING(h < l, "The bits selected will be returned in reverse order.");
#endif
  }

  INLINE af_range_ref(const ref_type* bv, int h, int l)
      : d_bv(*const_cast<ref_type*>(bv)), l_index(l), h_index(h) {
#ifndef __SYNTHESIS__
    _AP_WARNING(h < 0 || l < 0,
                "Higher bound(%d) and lower(%d) bound cannot be negative.", h,
                l);
    _AP_WARNING(h >= _AP_W || l >= _AP_W,
                "Higher bound(%d) or lower(%d) bound out of range.", h, l);
    _AP_WARNING(h < l, "The bits selected will be returned in reverse order.");
#endif
  }

  /// @name assign operators
  //  @{

#define ASSIGN_CTYPE_TO_AF_RANGE(DATA_TYPE)                          \
  INLINE af_range_ref& operator=(const DATA_TYPE val) {              \
    ap_int_base<_AP_W, false> loc(val);                              \
    d_bv.V = _AP_ROOT_op_set_range(d_bv.V, l_index, h_index, loc.V); \
    return *this;                                                    \
  }

  ASSIGN_CTYPE_TO_AF_RANGE(bool)
  ASSIGN_CTYPE_TO_AF_RANGE(char)
  ASSIGN_CTYPE_TO_AF_RANGE(signed char)
  ASSIGN_CTYPE_TO_AF_RANGE(unsigned char)
  ASSIGN_CTYPE_TO_AF_RANGE(short)
  ASSIGN_CTYPE_TO_AF_RANGE(unsigned short)
  ASSIGN_CTYPE_TO_AF_RANGE(int)
  ASSIGN_CTYPE_TO_AF_RANGE(unsigned int)
  ASSIGN_CTYPE_TO_AF_RANGE(long)
  ASSIGN_CTYPE_TO_AF_RANGE(unsigned long)
  ASSIGN_CTYPE_TO_AF_RANGE(ap_slong)
  ASSIGN_CTYPE_TO_AF_RANGE(ap_ulong)
  ASSIGN_CTYPE_TO_AF_RANGE(half)
  ASSIGN_CTYPE_TO_AF_RANGE(float)
  ASSIGN_CTYPE_TO_AF_RANGE(double)
#undef ASSIGN_CTYPE_TO_AF_RANGE

  /// assgin using a string. XXX crucial for cosim.
  INLINE af_range_ref& operator=(const char* val) {
    const ap_int_base<_AP_W, false> tmp(val); // XXX figure out radix
    d_bv.V = _AP_ROOT_op_set_range(d_bv.V, l_index, h_index, tmp.V);
    return *this;
  }

  /// assign from ap_int_base.
  // NOTE Base of other assgin operators.
  template <int _AP_W3, bool _AP_S3>
  INLINE af_range_ref& operator=(const ap_int_base<_AP_W3, _AP_S3>& val) {
    d_bv.V = _AP_ROOT_op_set_range(d_bv.V, l_index, h_index, val.V);
    return *this;
  }

  /// assign from range reference to ap_int_base.
  template <int _AP_W2, bool _AP_S2>
  INLINE af_range_ref& operator=(const ap_range_ref<_AP_W2, _AP_S2>& val) {
    const ap_int_base<_AP_W2, false> tmp(val);
    return operator=(tmp);
  }

  /// assign from bit reference to ap_int_base..
  template <int _AP_W2, bool _AP_S2>
  INLINE af_range_ref& operator=(const ap_bit_ref<_AP_W2, _AP_S2>& val) {
    const ap_int_base<1, false> tmp((bool)val);
    return operator=(tmp);
  }

  /// assgin from ap_fixed_base.
  template <int _AP_W2, int _AP_I2, bool _AP_S2, ap_q_mode _AP_Q2,
            ap_o_mode _AP_O2, int _AP_N2>
  INLINE af_range_ref& operator=(
      const ap_fixed_base<_AP_W2, _AP_I2, _AP_S2, _AP_Q2, _AP_O2, _AP_N2>&
          val) {
    d_bv.V = _AP_ROOT_op_set_range(d_bv.V, l_index, h_index, val.V);
    return *this;
  }

  /// copy assgin.
  // XXX This has to be explicit, otherwise it will be deleted, as d_bv is
  // of reference type.
  INLINE af_range_ref& operator=(const af_range_ref& val) {
    ap_int_base<_AP_W, false> tmp(val);
    return operator=(tmp);
  }

  /// assign from range reference to ap_fixed_base.
  template <int _AP_W2, int _AP_I2, bool _AP_S2, ap_q_mode _AP_Q2,
            ap_o_mode _AP_O2, int _AP_N2>
  INLINE af_range_ref& operator=(
      const af_range_ref<_AP_W2, _AP_I2, _AP_S2, _AP_Q2, _AP_O2, _AP_N2>& val) {
    ap_int_base<_AP_W2, false> tmp(val);
    return operator=(tmp);
  }

  /// assign from bit reference to ap_fixed_base.
  template <int _AP_W2, int _AP_I2, bool _AP_S2, ap_q_mode _AP_Q2,
            ap_o_mode _AP_O2, int _AP_N2>
  INLINE af_range_ref& operator=(
      const af_bit_ref<_AP_W2, _AP_I2, _AP_S2, _AP_Q2, _AP_O2, _AP_N2>& val) {
    ap_int_base<1, false> tmp((bool)val);
    return operator=(tmp);
  }

  /// assign from compound reference.
  template <int _AP_W2, typename _AP_T2, int _AP_W3, typename _AP_T3>
  INLINE af_range_ref& operator=(
      const ap_concat_ref<_AP_W2, _AP_T3, _AP_W3, _AP_T3>& val) {
    const ap_int_base<_AP_W2 + _AP_W3, false> tmp(val);
    return operator=(tmp);
  }
  //  @}

  /// @name comparison operators with ap_range_ref.
  //  @{
  template <int _AP_W2, bool _AP_S2>
  INLINE bool operator==(const ap_range_ref<_AP_W2, _AP_S2>& op2) {
    ap_int_base<_AP_W, false> lop(*this);
    ap_int_base<_AP_W2, false> rop(op2);
    return lop == rop;
  }

  template <int _AP_W2, bool _AP_S2>
  INLINE bool operator!=(const ap_range_ref<_AP_W2, _AP_S2>& op2) {
    return !(operator==(op2));
  }

  template <int _AP_W2, bool _AP_S2>
  INLINE bool operator<(const ap_range_ref<_AP_W2, _AP_S2>& op2) {
    ap_int_base<_AP_W, false> lop(*this);
    ap_int_base<_AP_W2, false> rop(op2);
    return lop < rop;
  }

  template <int _AP_W2, bool _AP_S2>
  INLINE bool operator>(const ap_range_ref<_AP_W2, _AP_S2>& op2) {
    ap_int_base<_AP_W, false> lop(*this);
    ap_int_base<_AP_W2, false> rop(op2);
    return lop > rop;
  }

  template <int _AP_W2, bool _AP_S2>
  INLINE bool operator<=(const ap_range_ref<_AP_W2, _AP_S2>& op2) {
    return !(operator>(op2));
  }

  template <int _AP_W2, bool _AP_S2>
  INLINE bool operator>=(const ap_range_ref<_AP_W2, _AP_S2>& op2) {
    return !(operator<(op2));
  }
  //  @}

  /// @name comparison operators with af_range_ref.
  //  @{
  template <int _AP_W2, int _AP_I2, bool _AP_S2, ap_q_mode _AP_Q2,
            ap_o_mode _AP_O2, int _AP_N2>
  INLINE bool operator==(
      const af_range_ref<_AP_W2, _AP_I2, _AP_S2, _AP_Q2, _AP_O2, _AP_N2>& op2) {
    ap_int_base<_AP_W, false> lop(*this);
    ap_int_base<_AP_W2, false> rop(op2);
    return lop == rop;
  }

  template <int _AP_W2, int _AP_I2, bool _AP_S2, ap_q_mode _AP_Q2,
            ap_o_mode _AP_O2, int _AP_N2>
  INLINE bool operator!=(
      const af_range_ref<_AP_W2, _AP_I2, _AP_S2, _AP_Q2, _AP_O2, _AP_N2>& op2) {
    return !(operator==(op2));
  }

  template <int _AP_W2, int _AP_I2, bool _AP_S2, ap_q_mode _AP_Q2,
            ap_o_mode _AP_O2, int _AP_N2>
  INLINE bool operator<(
      const af_range_ref<_AP_W2, _AP_I2, _AP_S2, _AP_Q2, _AP_O2, _AP_N2>& op2) {
    ap_int_base<_AP_W, false> lop(*this);
    ap_int_base<_AP_W2, false> rop(op2);
    return lop < rop;
  }

  template <int _AP_W2, int _AP_I2, bool _AP_S2, ap_q_mode _AP_Q2,
            ap_o_mode _AP_O2, int _AP_N2>
  INLINE bool operator>(
      const af_range_ref<_AP_W2, _AP_I2, _AP_S2, _AP_Q2, _AP_O2, _AP_N2>& op2) {
    ap_int_base<_AP_W, false> lop(*this);
    ap_int_base<_AP_W2, false> rop(op2);
    return lop > rop;
  }

  template <int _AP_W2, int _AP_I2, bool _AP_S2, ap_q_mode _AP_Q2,
            ap_o_mode _AP_O2, int _AP_N2>
  INLINE bool operator<=(
      const af_range_ref<_AP_W2, _AP_I2, _AP_S2, _AP_Q2, _AP_O2, _AP_N2>& op2) {
    return !(operator>(op2));
  }

  template <int _AP_W2, int _AP_I2, bool _AP_S2, ap_q_mode _AP_Q2,
            ap_o_mode _AP_O2, int _AP_N2>
  INLINE bool operator>=(
      const af_range_ref<_AP_W2, _AP_I2, _AP_S2, _AP_Q2, _AP_O2, _AP_N2>& op2) {
    return !(operator<(op2));
  }
  //  @}

  /// @name concatenate operators.
  /// @{
  /// concatenate with ap_int_base.
  template <int _AP_W2, int _AP_S2>
  INLINE
      ap_concat_ref<_AP_W, af_range_ref, _AP_W2, ap_int_base<_AP_W2, _AP_S2> >
      operator,(ap_int_base<_AP_W2, _AP_S2> &op) {
    return ap_concat_ref<_AP_W, af_range_ref, _AP_W2,
                         ap_int_base<_AP_W2, _AP_S2> >(*this, op);
  }

  /// concatenate with ap_bit_ref.
  template <int _AP_W2, int _AP_S2>
  INLINE ap_concat_ref<_AP_W, af_range_ref, 1, ap_bit_ref<_AP_W2, _AP_S2> >
  operator,(const ap_bit_ref<_AP_W2, _AP_S2> &op) {
    return ap_concat_ref<_AP_W, af_range_ref, 1, ap_bit_ref<_AP_W2, _AP_S2> >(
        *this, const_cast<ap_bit_ref<_AP_W2, _AP_S2>&>(op));
  }

  /// concatenate with ap_bit_ref.
  template <int _AP_W2, int _AP_S2>
  INLINE ap_concat_ref<_AP_W, af_range_ref, _AP_W2, ap_range_ref<_AP_W2, _AP_S2> >
  operator,(const ap_range_ref<_AP_W2, _AP_S2> &op) {
    return ap_concat_ref<_AP_W, af_range_ref, _AP_W2,
                         ap_range_ref<_AP_W2, _AP_S2> >(
        *this, const_cast<ap_range_ref<_AP_W2, _AP_S2>&>(op));
  }

  /// concatenate with ap_concat_ref.
  template <int _AP_W2, typename _AP_T2, int _AP_W3, typename _AP_T3>
  INLINE ap_concat_ref<_AP_W, af_range_ref, _AP_W2 + _AP_W3,
                       ap_concat_ref<_AP_W2, _AP_T2, _AP_W3, _AP_T3> >
  operator,(const ap_concat_ref<_AP_W2, _AP_T2, _AP_W3, _AP_T3> &op) {
    return ap_concat_ref<_AP_W, af_range_ref, _AP_W2 + _AP_W3,
                         ap_concat_ref<_AP_W2, _AP_T2, _AP_W3, _AP_T3> >(
        *this, const_cast<ap_concat_ref<_AP_W2, _AP_T2, _AP_W3, _AP_T3>&>(op));
  }

  /// concatenate with another af_range_ref.
  template <int _AP_W2, int _AP_I2, bool _AP_S2, ap_q_mode _AP_Q2,
            ap_o_mode _AP_O2, int _AP_N2>
  INLINE
      ap_concat_ref<_AP_W, af_range_ref, _AP_W2,
                    af_range_ref<_AP_W2, _AP_I2, _AP_S2, _AP_Q2, _AP_O2, _AP_N2> >
      operator,(const af_range_ref<_AP_W2, _AP_I2, _AP_S2, _AP_Q2, _AP_O2, _AP_N2>
                    &op) {
    return ap_concat_ref<
        _AP_W, af_range_ref, _AP_W2,
        af_range_ref<_AP_W2, _AP_I2, _AP_S2, _AP_Q2, _AP_O2, _AP_N2> >(
        *this,
        const_cast<af_range_ref<_AP_W2, _AP_I2, _AP_S2, _AP_Q2, _AP_O2, _AP_N2>&>(
            op));
  }

  /// concatenate with another af_bit_ref.
  template <int _AP_W2, int _AP_I2, bool _AP_S2, ap_q_mode _AP_Q2,
            ap_o_mode _AP_O2, int _AP_N2>
  INLINE
      ap_concat_ref<_AP_W, af_range_ref, 1,
                    af_bit_ref<_AP_W2, _AP_I2, _AP_S2, _AP_Q2, _AP_O2, _AP_N2> >
      operator,(
          const af_bit_ref<_AP_W2, _AP_I2, _AP_S2, _AP_Q2, _AP_O2, _AP_N2> &op) {
    return ap_concat_ref<
        _AP_W, af_range_ref, 1,
        af_bit_ref<_AP_W2, _AP_I2, _AP_S2, _AP_Q2, _AP_O2, _AP_N2> >(
        *this,
        const_cast<af_bit_ref<_AP_W2, _AP_I2, _AP_S2, _AP_Q2, _AP_O2, _AP_N2>&>(
            op));
  }
  //  @}

  INLINE operator ap_ulong() const {
    ap_int_base<_AP_W, false> ret;
    ret.V = _AP_ROOT_op_get_range(d_bv.V, l_index, h_index);
    return ret.to_uint64();
  }

  INLINE operator ap_int_base<_AP_W, false>() const {
    ap_int_base<_AP_W, false> ret;
    ret.V = _AP_ROOT_op_get_range(d_bv.V, l_index, h_index);
    return ret;
  }

  INLINE ap_int_base<_AP_W, false> to_ap_int_base() const {
    ap_int_base<_AP_W, false> ret;
    ret.V = _AP_ROOT_op_get_range(d_bv.V, l_index, h_index);
    return ret;
  }

  // used in ap_fixed_base::to_string()
  INLINE char to_char() const {
    return (char)(_AP_ROOT_op_get_range(d_bv.V, l_index, h_index));
  }

  INLINE int to_int() const {
    return (int)(_AP_ROOT_op_get_range(d_bv.V, l_index, h_index));
  }

  INLINE unsigned to_uint() const {
    return (unsigned)(_AP_ROOT_op_get_range(d_bv.V, l_index, h_index));
  }

  INLINE long to_long() const {
    return (long)(_AP_ROOT_op_get_range(d_bv.V, l_index, h_index));
  }

  INLINE unsigned long to_ulong() const {
    return (unsigned long)(_AP_ROOT_op_get_range(d_bv.V, l_index, h_index));
  }

  INLINE ap_slong to_int64() const {
    return (ap_slong)(_AP_ROOT_op_get_range(d_bv.V, l_index, h_index));
  }

  INLINE ap_ulong to_uint64() const {
    return (ap_ulong)(_AP_ROOT_op_get_range(d_bv.V, l_index, h_index));
  }

  INLINE ap_int_base<_AP_W, false> get() const {
    ap_int_base<_AP_W, false> ret;
    ret.V = _AP_ROOT_op_get_range(d_bv.V, l_index, h_index);
    return ret;
  }

  template <int _AP_W2>
  INLINE void set(const ap_int_base<_AP_W2, false>& val) {
    d_bv.V = _AP_ROOT_op_set_range(d_bv.V, l_index, h_index, val.V);
  }

  INLINE int length() const {
    return h_index >= l_index ? h_index - l_index + 1 : l_index - h_index + 1;
  }

#ifndef __SYNTHESIS__
  std::string to_string(signed char rd = 2) const {
    ap_int_base<_AP_W, false> ret;
    ret.V = _AP_ROOT_op_get_range(d_bv.V, l_index, h_index);
    return ret.to_string(rd);
  }
#else
  // XXX HLS will delete this in synthesis
  INLINE char* to_string(signed char rd = 2) const {
    return 0;
  }
#endif
}; // struct af_range_ref

// XXX apcc cannot handle global std::ios_base::Init() brought in by <iostream>
#ifndef AP_AUTOCC
#ifndef __SYNTHESIS__
template <int _AP_W, int _AP_I, bool _AP_S, ap_q_mode _AP_Q, ap_o_mode _AP_O,
          int _AP_N>
INLINE std::ostream& operator<<(
    std::ostream& os,
    const af_range_ref<_AP_W, _AP_I, _AP_S, _AP_Q, _AP_O, _AP_N>& x) {
  os << x.to_string();
  return os;
}
#endif
#endif // ifndef AP_AUTOCC

#define AF_REF_REL_OP_WITH_INT(REL_OP, C_TYPE, _AP_W2, _AP_S2)            \
  template <int _AP_W, int _AP_I, bool _AP_S, ap_q_mode _AP_Q,            \
            ap_o_mode _AP_O, int _AP_N>                                   \
  INLINE bool operator REL_OP(                                            \
      const af_range_ref<_AP_W, _AP_I, _AP_S, _AP_Q, _AP_O, _AP_N>& op,   \
      C_TYPE op2) {                                                       \
    return ap_int_base<_AP_W, false>(op)                                  \
        REL_OP ap_int_base<_AP_W2, _AP_S2>(op2);                          \
  }                                                                       \
                                                                          \
  template <int _AP_W, int _AP_I, bool _AP_S, ap_q_mode _AP_Q,            \
            ap_o_mode _AP_O, int _AP_N>                                   \
  INLINE bool operator REL_OP(                                            \
      C_TYPE op2,                                                         \
      const af_range_ref<_AP_W, _AP_I, _AP_S, _AP_Q, _AP_O, _AP_N>& op) { \
    return ap_int_base<_AP_W2, _AP_S2>(op2)                               \
        REL_OP ap_int_base<_AP_W, false>(op);                             \
  }                                                                       \
                                                                          \
  template <int _AP_W, int _AP_I, bool _AP_S, ap_q_mode _AP_Q,            \
            ap_o_mode _AP_O, int _AP_N>                                   \
  INLINE bool operator REL_OP(                                            \
      const af_bit_ref<_AP_W, _AP_I, _AP_S, _AP_Q, _AP_O, _AP_N>& op,     \
      C_TYPE op2) {                                                       \
    return bool(op) REL_OP op2;                                           \
  }                                                                       \
                                                                          \
  template <int _AP_W, int _AP_I, bool _AP_S, ap_q_mode _AP_Q,            \
            ap_o_mode _AP_O, int _AP_N>                                   \
  INLINE bool operator REL_OP(                                            \
      C_TYPE op2,                                                         \
      const af_bit_ref<_AP_W, _AP_I, _AP_S, _AP_Q, _AP_O, _AP_N>& op) {   \
    return op2 REL_OP bool(op);                                           \
  }

#define AF_REF_REL_OPS_WITH_INT(C_TYPE, _AP_W2, _AP_S2)  \
  AF_REF_REL_OP_WITH_INT(>, C_TYPE, (_AP_W2), (_AP_S2))  \
  AF_REF_REL_OP_WITH_INT(<, C_TYPE, (_AP_W2), (_AP_S2))  \
  AF_REF_REL_OP_WITH_INT(>=, C_TYPE, (_AP_W2), (_AP_S2)) \
  AF_REF_REL_OP_WITH_INT(<=, C_TYPE, (_AP_W2), (_AP_S2)) \
  AF_REF_REL_OP_WITH_INT(==, C_TYPE, (_AP_W2), (_AP_S2)) \
  AF_REF_REL_OP_WITH_INT(!=, C_TYPE, (_AP_W2), (_AP_S2))

AF_REF_REL_OPS_WITH_INT(bool, 1, false)
AF_REF_REL_OPS_WITH_INT(char, 8, CHAR_IS_SIGNED)
AF_REF_REL_OPS_WITH_INT(signed char, 8, true)
AF_REF_REL_OPS_WITH_INT(unsigned char, 8, false)
AF_REF_REL_OPS_WITH_INT(short, _AP_SIZE_short, true)
AF_REF_REL_OPS_WITH_INT(unsigned short, _AP_SIZE_short, false)
AF_REF_REL_OPS_WITH_INT(int, _AP_SIZE_int, true)
AF_REF_REL_OPS_WITH_INT(unsigned int, _AP_SIZE_int, false)
AF_REF_REL_OPS_WITH_INT(long, _AP_SIZE_long, true)
AF_REF_REL_OPS_WITH_INT(unsigned long, _AP_SIZE_long, false)
AF_REF_REL_OPS_WITH_INT(ap_slong, _AP_SIZE_ap_slong, true)
AF_REF_REL_OPS_WITH_INT(ap_ulong, _AP_SIZE_ap_slong, false)

#undef AF_REF_REL_OP_INT
#undef AF_REF_REL_OPS_WITH_INT

#define AF_REF_REL_OP_WITH_AP_INT(REL_OP)                                 \
  template <int _AP_W, int _AP_I, bool _AP_S, ap_q_mode _AP_Q,            \
            ap_o_mode _AP_O, int _AP_N, int _AP_W2, bool _AP_S2>          \
  INLINE bool operator REL_OP(                                            \
      const af_range_ref<_AP_W, _AP_I, _AP_S, _AP_Q, _AP_O, _AP_N>& op,   \
      const ap_int_base<_AP_W2, _AP_S>& op2) {                            \
    return ap_int_base<_AP_W, false>(op) REL_OP op2;                      \
  }                                                                       \
  template <int _AP_W, int _AP_I, bool _AP_S, ap_q_mode _AP_Q,            \
            ap_o_mode _AP_O, int _AP_N, int _AP_W2, bool _AP_S2>          \
  INLINE bool operator REL_OP(                                            \
      const ap_int_base<_AP_W2, _AP_S2>& op2,                             \
      const af_range_ref<_AP_W, _AP_I, _AP_S, _AP_Q, _AP_O, _AP_N>& op) { \
    return op2 REL_OP ap_int_base<_AP_W, false>(op);                      \
  }                                                                       \
  template <int _AP_W, int _AP_I, bool _AP_S, ap_q_mode _AP_Q,            \
            ap_o_mode _AP_O, int _AP_N, int _AP_W2, bool _AP_S2>          \
  INLINE bool operator REL_OP(                                            \
      const af_bit_ref<_AP_W, _AP_I, _AP_S, _AP_Q, _AP_O, _AP_N>& op,     \
      const ap_int_base<_AP_W2, _AP_S2>& op2) {                           \
    return ap_int_base<1, false>(op) REL_OP op2;                          \
  }                                                                       \
  template <int _AP_W, int _AP_I, bool _AP_S, ap_q_mode _AP_Q,            \
            ap_o_mode _AP_O, int _AP_N, int _AP_W2, bool _AP_S2>          \
  INLINE bool operator REL_OP(                                            \
      const ap_int_base<_AP_W2, _AP_S2>& op2,                             \
      const af_bit_ref<_AP_W, _AP_I, _AP_S, _AP_Q, _AP_O, _AP_N>& op) {   \
    return op2 REL_OP ap_int_base<1, false>(op);                          \
  }

AF_REF_REL_OP_WITH_AP_INT(>)
AF_REF_REL_OP_WITH_AP_INT(<)
AF_REF_REL_OP_WITH_AP_INT(>=)
AF_REF_REL_OP_WITH_AP_INT(<=)
AF_REF_REL_OP_WITH_AP_INT(==)
AF_REF_REL_OP_WITH_AP_INT(!=)

#endif // ifndef __cplusplus

#endif // ifndef __AP_FIXED_REF_H__

// -*- cpp -*-


