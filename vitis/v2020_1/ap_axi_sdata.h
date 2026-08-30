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

 *
 *****************************************************************************/

/*
 * This file contains the definition of the data types for AXI streaming. 
 * ap_axi_s is a signed interpretation of the AXI stream
 * ap_axi_u is an unsigned interpretation of the AXI stream
 */

#ifndef __AP__AXI_SDATA__
#define __AP__AXI_SDATA__

#include "ap_int.h"

template<int D,int U,int TI,int TD>
  struct ap_axis{
    ap_int<D>        data;
    ap_uint<(D+7)/8> keep;
    ap_uint<(D+7)/8> strb;
    ap_uint<U>       user;
    ap_uint<1>       last;
    ap_uint<TI>      id;
    ap_uint<TD>      dest;
  };

template<int D>
  struct ap_axis <D, 0, 0, 0>{
    ap_int<D>        data;
    ap_uint<(D+7)/8> keep;
    ap_uint<(D+7)/8> strb;
    ap_uint<1>       last;
  };

template<int D,int U,int TI,int TD>
  struct ap_axiu{
    ap_uint<D>       data;
    ap_uint<(D+7)/8> keep;
    ap_uint<(D+7)/8> strb;
    ap_uint<U>       user;
    ap_uint<1>       last;
    ap_uint<TI>      id;
    ap_uint<TD>      dest;
  };

template<int D>
  struct ap_axiu <D, 0, 0, 0>{
    ap_uint<D>       data;
    ap_uint<(D+7)/8> keep;
    ap_uint<(D+7)/8> strb;
    ap_uint<1>       last;
  };


template<int D,int U,int TI,int TD> struct qdma_axis;

template<int D>
  struct qdma_axis <D, 0, 0, 0>{
//  private:
    ap_uint<D>       data;
    ap_uint<(D+7)/8> keep;
    ap_uint<1>       last;
//  public:
    ap_uint<D> get_data() const { return data; }
    ap_uint<(D+7)/8> get_keep() const { return keep; }
    ap_uint<1> get_last() const { return last; }

    void set_data(const ap_uint<D> &d) { data = d; }
    void set_keep(const ap_uint<(D+7)/8> &k) { keep = k; }
    void set_last(const ap_uint<1> &l) { last = l; }
    void keep_all() {
       ap_uint<(D+7)/8> k = 0;
       keep = ~k;
     }

    qdma_axis(ap_uint<D> d = ap_uint<D>(), ap_uint<(D+7)/8> k = ap_uint<(D+7)/8>(), ap_uint<1> l = ap_uint<1>()) : data(d), keep(k), last(l) {}
    qdma_axis(const qdma_axis<D, 0, 0, 0> &d) : data(d.data), keep(d.keep), last(d.last) {}
  };
#ifdef AESL_SYN 
#if ((__clang_major__ != 3) || (__clang_minor__ != 1))
#include "hls_stream.h"
namespace hls {

template <int D,int U,int TI,int TD>
class stream<ap_axis<D, U, TI, TD> > {
  using __STREAM_T__ = ap_axis<D, U, TI, TD>;
public:
  /// Constructors
  INLINE stream() {}

  INLINE stream(const char* name) {}

  /// Make copy constructor and assignment operator private
private:
  INLINE stream(const stream< __STREAM_T__ >& chn):V(chn.V) {}

  INLINE stream& operator= (const stream< __STREAM_T__ >& chn) {
    V = chn.V;
    return *this;
  }

public:
  /// Overload >> and << operators to implement read() and write()
  INLINE void operator >> (__STREAM_T__& rdata) {
    read(rdata);
  }

  INLINE void operator << (const __STREAM_T__& wdata) {
    write(wdata);
  }

  /// empty & full
  bool empty() const {
    #pragma HLS inline
    bool tmp = __fpga_axis_valid(&V.data, &V.keep, &V.strb, &V.user, &V.last,
                                 &V.id, &V.dest);
    return !tmp;
  }

  bool full() const {
    #pragma HLS inline
    bool tmp = __fpga_axis_ready(&V.data, &V.keep, &V.strb, &V.user, &V.last,
                                 &V.id, &V.dest);
    return !tmp;
  }


  /// Blocking read
  void read(__STREAM_T__ &dout) {
    #pragma HLS inline
    __fpga_axis_pop(&V.data, &V.keep, &V.strb,
                    &V.user, &V.last, &V.id, &V.dest,
                    &dout.data, &dout.keep, &dout.strb,
                    &dout.user, &dout.last, &dout.id, &dout.dest);
  }

  __STREAM_T__ read() {
    #pragma HLS inline
    __STREAM_T__ tmp;
    __fpga_axis_pop(&V.data, &V.keep, &V.strb,
                    &V.user, &V.last, &V.id, &V.dest,
                    &tmp.data, &tmp.keep, &tmp.strb,
                    &tmp.user, &tmp.last, &tmp.id, &tmp.dest);
    return tmp;
  }

  /// Blocking write
  void write(const __STREAM_T__ &din) {
    #pragma HLS inline
    __STREAM_T__ tmp = din;
    __fpga_axis_push(&V.data, &V.keep, &V.strb,
                     &V.user, &V.last, &V.id, &V.dest,
                     &tmp.data, &tmp.keep, &tmp.strb,
                     &tmp.user, &tmp.last, &tmp.id, &tmp.dest);
  }

  /// Non-Blocking read
  bool read_nb(__STREAM_T__& dout) {
    #pragma HLS inline
    bool valid =
    __fpga_axis_nb_pop(&V.data, &V.keep, &V.strb,
                       &V.user,&V.last, &V.id, &V.dest,
                       &dout.data, &dout.keep, &dout.strb,
                       &dout.user, &dout.last, &dout.id, &dout.dest);
    return empty_n;
  }

  /// Non-Blocking write
  bool write_nb(const __STREAM_T__& in) {
    #pragma HLS inline
    __STREAM_T__ tmp = in;
    bool valid =
     __fpga_axis_nb_push(&V.data, &V.keep, &V.strb,
                         &V.user, &V.last, &V.id, &V.dest,
                         &tmp.data, &tmp.keep, &tmp.strb,
                         &tmp.user, &tmp.last, &tmp.id, &tmp.dest);
    return full_n;
  }


  __STREAM_T__ V;

};

// Specialization
template <int D>
class stream<ap_axis<D, 0, 0, 0> > {
  using __STREAM_T__ = ap_axis<D, 0, 0, 0>;
public:
  /// Constructors
  INLINE stream() {}

  INLINE stream(const char* name) {}

  /// Make copy constructor and assignment operator private
private:
  INLINE stream(const stream< __STREAM_T__ >& chn):V(chn.V) {}

  INLINE stream& operator= (const stream< __STREAM_T__ >& chn) {
    V = chn.V;
    return *this;
  }

public:
  /// Overload >> and << operators to implement read() and write()
  INLINE void operator >> (__STREAM_T__& rdata) {
    read(rdata);
  }

  INLINE void operator << (const __STREAM_T__& wdata) {
    write(wdata);
  }

  /// Empty & Full
  bool empty() const {
    #pragma HLS inline
    bool tmp = __fpga_axis_valid(&V.data, &V.keep, &V.strb,
                                 ((int*)0), &V.last, ((int*)0), ((int*)0));
    return !tmp;
  }

  bool full() const {
    #pragma HLS inline
    bool tmp = __fpga_axis_ready(&V.data, &V.keep, &V.strb,
                                 ((int*)0), &V.last, ((int*)0), ((int*)0));
    return !tmp;
  }

  /// Blocking read
  void read(__STREAM_T__ &dout) {
    #pragma HLS inline
    __fpga_axis_pop(&V.data, &V.keep, &V.strb,
                    ((int*)0), &V.last, ((int*)0), ((int*)0),
                    &dout.data, &dout.keep, &dout.strb,
                    ((int*)0), &dout.last, ((int*)0), ((int*)0));
  }

  __STREAM_T__ read() {
    #pragma HLS inline
    __STREAM_T__ tmp;
    __fpga_axis_pop(&V.data, &V.keep, &V.strb,
                    ((int*)0), &V.last, ((int*)0), ((int*)0),
                    &tmp.data, &tmp.keep, &tmp.strb,
                    ((int*)0), &tmp.last, ((int*)0), ((int*)0));
    return tmp;
  }

  /// Nonblocking read
  bool read_nb(__STREAM_T__ &dout) {
    #pragma HLS inline
    bool valid =
    __fpga_axis_nb_pop(&V.data, &V.keep, &V.strb,
                       ((int*)0), &V.last, ((int*)0), ((int*)0),
                       &dout.data, &dout.keep, &dout.strb,
                       ((int*)0), &dout.last, ((int*)0), ((int*)0));
    return empty_n;
  }

  // Blocking write
  void write(const __STREAM_T__ &din) {
    #pragma HLS inline
    __STREAM_T__ tmp = din;
    __fpga_axis_push(&V.data, &V.keep, &V.strb,
                     ((int*)0), &V.last, ((int*)0), ((int*)0),
                     &tmp.data, &tmp.keep, &tmp.strb,
                     ((int*)0), &tmp.last, ((int*)0), ((int*)0));
  }

  /// Nonblocking write
  bool write_nb(const __STREAM_T__ &din) {
    #pragma HLS inline
    __STREAM_T__ tmp = din;
    bool valid =
    __fpga_axis_nb_push(&V.data, &V.keep, &V.strb,
                        ((int*)0), &V.last, ((int*)0), ((int*)0),
                        &tmp.data, &tmp.keep, &tmp.strb,
                        ((int*)0), &tmp.last, ((int*)0), ((int*)0));
    return full_n;
  }

  /// Fifo size
  //inline unsigned size() {
  //  unsigned size = __fpga_axis_size(&V);
  //  return size;
  //}

  __STREAM_T__ V;
};

// ap_axiu
template <int D,int U,int TI,int TD>
class stream<ap_axiu<D, U, TI, TD> > {
  using __STREAM_T__ = ap_axiu<D, U, TI, TD> ;
public:
  /// Constructors
  INLINE stream() {}

  INLINE stream(const char* name) {}

  /// Make copy constructor and assignment operator private
private:
  INLINE stream(const stream< __STREAM_T__ >& chn):V(chn.V) {}

  INLINE stream& operator= (const stream< __STREAM_T__ >& chn) {
    V = chn.V;
    return *this;
  }

public:
  /// Overload >> and << operators to implement read() and write()
  INLINE void operator >> (__STREAM_T__& rdata) {
    read(rdata);
  }

  INLINE void operator << (const __STREAM_T__& wdata) {
    write(wdata);
  }

  /// empty & full
  bool empty() const {
    #pragma HLS inline
    bool tmp = __fpga_axis_valid(&V.data, &V.keep, &V.strb, &V.user, &V.last,
                                 &V.id, &V.dest);
    return !tmp;
  }

  bool full() const {
    #pragma HLS inline
    bool tmp = __fpga_axis_ready(&V.data, &V.keep, &V.strb, &V.user, &V.last,
                                 &V.id, &V.dest);
    return !tmp;
  }


  /// Blocking read
  void read(__STREAM_T__ &dout) {
    #pragma HLS inline
    __fpga_axis_pop(&V.data, &V.keep, &V.strb,
                    &V.user, &V.last, &V.id, &V.dest,
                    &dout.data, &dout.keep, &dout.strb,
                    &dout.user, &dout.last, &dout.id, &dout.dest);
  }

  __STREAM_T__ read() {
    #pragma HLS inline
    __STREAM_T__ tmp;
    __fpga_axis_pop(&V.data, &V.keep, &V.strb,
                    &V.user, &V.last, &V.id, &V.dest,
                    &tmp.data, &tmp.keep, &tmp.strb,
                    &tmp.user, &tmp.last, &tmp.id, &tmp.dest);
    return tmp;
  }

  /// Blocking write
  void write(const __STREAM_T__ &din) {
    #pragma HLS inline
    __STREAM_T__ tmp = din;
    __fpga_axis_push(&V.data, &V.keep, &V.strb,
                     &V.user, &V.last, &V.id, &V.dest,
                     &tmp.data, &tmp.keep, &tmp.strb,
                     &tmp.user, &tmp.last, &tmp.id, &tmp.dest);
  }

  /// Non-Blocking read
  bool read_nb(__STREAM_T__& dout) {
    #pragma HLS inline
    bool valid =
    __fpga_axis_nb_pop(&V.data, &V.keep, &V.strb,
                       &V.user,&V.last, &V.id, &V.dest,
                       &dout.data, &dout.keep, &dout.strb,
                       &dout.user, &dout.last, &dout.id, &dout.dest);
    return empty_n;
  }

  /// Non-Blocking write
  bool write_nb(const __STREAM_T__& in) {
    #pragma HLS inline
    __STREAM_T__ tmp = in;
    bool valid =
     __fpga_axis_nb_push(&V.data, &V.keep, &V.strb,
                         &V.user, &V.last, &V.id, &V.dest,
                         &tmp.data, &tmp.keep, &tmp.strb,
                         &tmp.user, &tmp.last, &tmp.id, &tmp.dest);
    return full_n;
  }


  __STREAM_T__ V;

};

// Specialization
template <int D>
class stream<ap_axiu<D, 0, 0, 0> > {
  using __STREAM_T__ = ap_axiu<D, 0, 0, 0>;
public:
  /// Constructors
  INLINE stream() {}

  INLINE stream(const char* name) {}

  /// Make copy constructor and assignment operator private
private:
  INLINE stream(const stream< __STREAM_T__ >& chn):V(chn.V) {}

  INLINE stream& operator= (const stream< __STREAM_T__ >& chn) {
    V = chn.V;
    return *this;
  }

public:
  /// Overload >> and << operators to implement read() and write()
  INLINE void operator >> (__STREAM_T__& rdata) {
    read(rdata);
  }

  INLINE void operator << (const __STREAM_T__& wdata) {
    write(wdata);
  }

  /// Empty & Full
  bool empty() const {
    #pragma HLS inline
    bool tmp = __fpga_axis_valid(&V.data, &V.keep, &V.strb,
                                 ((int*)0), &V.last, ((int*)0), ((int*)0));
    return !tmp;
  }

  bool full() const {
    #pragma HLS inline
    bool tmp = __fpga_axis_ready(&V.data, &V.keep, &V.strb,
                                 ((int*)0), &V.last, ((int*)0), ((int*)0));
    return !tmp;
  }

  /// Blocking read
  void read(__STREAM_T__ &dout) {
    #pragma HLS inline
    __fpga_axis_pop(&V.data, &V.keep, &V.strb,
                    ((int*)0), &V.last, ((int*)0), ((int*)0),
                    &dout.data, &dout.keep, &dout.strb,
                    ((int*)0), &dout.last, ((int*)0), ((int*)0));
  }

  __STREAM_T__ read() {
    #pragma HLS inline
    __STREAM_T__ tmp;
    __fpga_axis_pop(&V.data, &V.keep, &V.strb,
                    ((int*)0), &V.last, ((int*)0), ((int*)0),
                    &tmp.data, &tmp.keep, &tmp.strb,
                    ((int*)0), &tmp.last, ((int*)0), ((int*)0));
    return tmp;
  }

  /// Nonblocking read
  bool read_nb(__STREAM_T__ &dout) {
    #pragma HLS inline
    bool valid =
    __fpga_axis_nb_pop(&V.data, &V.keep, &V.strb,
                       ((int*)0), &V.last, ((int*)0), ((int*)0),
                       &dout.data, &dout.keep, &dout.strb,
                       ((int*)0), &dout.last, ((int*)0), ((int*)0));
    return empty_n;
  }

  // Blocking write
  void write(const __STREAM_T__ &din) {
    #pragma HLS inline
    __STREAM_T__ tmp = din;
    __fpga_axis_push(&V.data, &V.keep, &V.strb,
                     ((int*)0), &V.last, ((int*)0), ((int*)0),
                     &tmp.data, &tmp.keep, &tmp.strb,
                     ((int*)0), &tmp.last, ((int*)0), ((int*)0));
  }

  /// Nonblocking write
  bool write_nb(const __STREAM_T__ &din) {
    #pragma HLS inline
    __STREAM_T__ tmp = din;
    bool valid =
    __fpga_axis_nb_push(&V.data, &V.keep, &V.strb,
                        ((int*)0), &V.last, ((int*)0), ((int*)0),
                        &tmp.data, &tmp.keep, &tmp.strb,
                        ((int*)0), &tmp.last, ((int*)0), ((int*)0));
    return full_n;
  }

  /// Fifo size
  //inline unsigned size() {
  //  unsigned size = __fpga_axis_size(&V);
  //  return size;
  //}

  __STREAM_T__ V;
};

// Specialization for qdma
template <int D>
class stream<qdma_axis<D, 0, 0, 0> > {
  using __STREAM_T__ = qdma_axis<D, 0, 0, 0>;
public:
  /// Constructors
  INLINE stream() {}

  INLINE stream(const char* name) {}

  /// Make copy constructor and assignment operator private
private:
  INLINE stream(const stream< __STREAM_T__ >& chn):V(chn.V) {}

  INLINE stream& operator= (const stream< __STREAM_T__ >& chn) {
    V = chn.V;
    return *this;
  }

public:
  /// Overload >> and << operators to implement read() and write()
  INLINE void operator >> (__STREAM_T__& rdata) {
    read(rdata);
  }

  INLINE void operator << (const __STREAM_T__& wdata) {
    write(wdata);
  }

  /// Empty & Full
  bool empty() const {
    #pragma HLS inline
    bool tmp = __fpga_axis_valid(&V.data, &V.keep, ((int*)0),
                                 ((int*)0), &V.last, ((int*)0), ((int*)0));
    return !tmp;
  }

  bool full() const {
    #pragma HLS inline
    bool tmp = __fpga_axis_ready(&V.data, &V.keep, ((int*)0),
                                 ((int*)0), &V.last, ((int*)0), ((int*)0));
    return !tmp;
  }

  /// Blocking read
  void read(__STREAM_T__ &dout) {
    #pragma HLS inline
    __fpga_axis_pop(&V.data, &V.keep, ((int*)0),
                    ((int*)0), &V.last, ((int*)0), ((int*)0),
                    &dout.data, &dout.keep, ((int*)0),
                    ((int*)0), &dout.last, ((int*)0), ((int*)0));
  }

  __STREAM_T__ read() {
    #pragma HLS inline
    __STREAM_T__ tmp;
    __fpga_axis_pop(&V.data, &V.keep, ((int*)0),
                    ((int*)0), &V.last, ((int*)0), ((int*)0),
                    &tmp.data, &tmp.keep, ((int*)0),
                    ((int*)0), &tmp.last, ((int*)0), ((int*)0));
    return tmp;
  }

  /// Nonblocking read
  bool read_nb(__STREAM_T__ &dout) {
    #pragma HLS inline
    bool valid =
    __fpga_axis_nb_pop(&V.data, &V.keep, ((int*)0),
                       ((int*)0), &V.last, ((int*)0), ((int*)0),
                       &dout.data, &dout.keep, ((int*)0),
                       ((int*)0), &dout.last, ((int*)0), ((int*)0));
    return empty_n;
  }

  // Blocking write
  void write(const __STREAM_T__ &din) {
    #pragma HLS inline
    __STREAM_T__ tmp = din;
    __fpga_axis_push(&V.data, &V.keep, ((int*)0),
                     ((int*)0), &V.last, ((int*)0), ((int*)0),
                     &tmp.data, &tmp.keep, ((int*)0),
                     ((int*)0), &tmp.last, ((int*)0), ((int*)0));
  }

  /// Nonblocking write
  bool write_nb(const __STREAM_T__ &din) {
    #pragma HLS inline
    __STREAM_T__ tmp = din;
    bool valid =
    __fpga_axis_nb_push(&V.data, &V.keep, ((int*)0),
                        ((int*)0), &V.last, ((int*)0), ((int*)0),
                        &tmp.data, &tmp.keep, ((int*)0),
                        ((int*)0), &tmp.last, ((int*)0), ((int*)0));
    return full_n;
  }

  /// Fifo size
  //inline unsigned size() {
  //  unsigned size = __fpga_axis_size(&V);
  //  return size;
  //}

  __STREAM_T__ V;
};

} // end of hls namespace
#endif
#endif
#endif
