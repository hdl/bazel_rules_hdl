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
 *     (c) Copyright 2014 Xilinx Inc.
 *     All rights reserved.
 *
 *****************************************************************************/

#ifndef HLS_DSP_COMMON_UTILS_H
#define HLS_DSP_COMMON_UTILS_H

#include <complex>
#include "ap_int.h"

namespace hls {

  // ===================================================================================================================
  // Common utility functions

  // Compute log2 rounded-up at compile time to determine the
  // number of bits required to represent a value (typically the
  // width of a data bus)
  template<int a, unsigned p=0> struct bitstorepresent {
    enum { bits = bitstorepresent<(a/2),p+1>::bits };
  };
  template<unsigned p> struct bitstorepresent<0, p> {
    enum { bits = p };
  };
  template<unsigned p> struct bitstorepresent<1, p> {
    enum { bits = p+1 };
  };


  // ===================================================================================================================
  // QAM4: Class definition
  // Describes a QAM4/QPSK constellation
  class QAM4 {
  public:
    const static int QAMTYPE = 0;
    const static int SYMBOL_WIDTH = 2;
    const static int STAR_WIDTH = 2;
    typedef ap_uint< SYMBOL_WIDTH > t_symbol;
    typedef ap_int< STAR_WIDTH > t_stardim;
    typedef std::complex< t_stardim > t_star;
    typedef ap_int< SYMBOL_WIDTH/2+1 > t_iq_comp;
    typedef std::complex< t_iq_comp > t_hard_in;

    static void hardEncode(const t_symbol &symbol, t_star &iq) {
      //QPSK/QAM4 constellation looks like this:
      // 10  |  00
      //-----+-----
      // 11  |  01
      t_stardim re,im;
      re  = ((symbol >> 1) &1) <<1;
      re += 1; //all stars are offset by 1.
      im  = ((symbol >> 0) &1) <<1;
      im += 1;

      iq.real(re);
      iq.imag(im);
    } //end of hardEncode

    static void hardDecode(const t_hard_in &hardIn, t_symbol &symbol) {
      //QPSK/QAM4 constellation looks like this:
      // 10  |  00
      //-----+-----
      // 11  |  01
      t_iq_comp re, im;
      re = hardIn.real();
      im = hardIn.imag();
      symbol  = ( (re >> 0 ) & 1 ) << 1;
      symbol += ( (im >> 0 ) & 1 );
    } //end of hardDecode
  };

  // ===================================================================================================================
  // QPSK: Class definition
  // Describes a QPSK (QAM4) constellation
  class QPSK : public QAM4 {
  public:
  };

  // ===================================================================================================================
  // QAM16: Class definition
  // Describes a QAM16 constellation
  class QAM16 {
  public:
    const static int QAMTYPE = 1;
    const static int SYMBOL_WIDTH = 4;
    const static int STAR_WIDTH = 3;
    typedef ap_uint< SYMBOL_WIDTH > t_symbol;
    typedef ap_int< STAR_WIDTH > t_stardim;
    typedef std::complex< t_stardim > t_star;
    typedef ap_int< SYMBOL_WIDTH/2+1 > t_iq_comp;
    typedef std::complex< t_iq_comp > t_hard_in;

    static void hardEncode(const t_symbol &symbol, t_star &iq) {
      //QAM16 Constellation looks like this
      //1011  1001 +3 0001  0011
      //            |
      //1010  1000 +1 0000  0010
      // -3 -- -1 --+- +1 -- +3 --
      //1110  1100 -1 0100  0110
      //            |
      //1111  1101 -3 0101  0111
      t_stardim re,im;
      re  = ((symbol >> 3) &1 ) << 2;
      re += ((symbol >> 1) &1 ) << 1;
      re += 1;
      im  = ((symbol >> 2) &1 ) << 2;
      im += ((symbol >> 0) &1 ) << 1;
      im += 1;

      iq.real(re);
      iq.imag(im);
    } //end of hardEncode

    static void hardDecode(const t_hard_in &hardIn, t_symbol &symbol) {
      //QAM16 Constellation looks like this
      //1011  1001 +3 0001  0011
      //            |
      //1010  1000 +1 0000  0010
      // -3 -- -1 --+- +1 -- +3 --
      //1110  1100 -1 0100  0110
      //            |
      //1111  1101 -3 0101  0111
      t_iq_comp re, im;
      re = hardIn.real();
      im = hardIn.imag();
      symbol  = (              (re >> 1)  &  1 ) << 3;
      symbol += (              (im >> 1)  &  1 ) << 2;
      symbol += ( ((re >> 0) ^ (re >> 1)) &  1 ) << 1;
      symbol += ( ((im >> 0) ^ (im >> 1)) &  1 );
    } //end of hardDecode
  };

  // ===================================================================================================================
  // QAM64: Class definition
  // Describes a QAM64 constellation
  class QAM64 {
  public:
    const static int QAMTYPE = 2;
    const static int SYMBOL_WIDTH = 6;
    const static int STAR_WIDTH = 4;
    typedef ap_uint< SYMBOL_WIDTH > t_symbol;
    typedef ap_int< STAR_WIDTH > t_stardim;
    typedef std::complex< t_stardim > t_star;
    typedef ap_int< SYMBOL_WIDTH/2+1 > t_iq_comp;
    typedef std::complex< t_iq_comp > t_hard_in;

    static void hardEncode(const t_symbol &symbol, t_star &iq) {
      t_stardim re,im;
      re  = ((                                 (symbol >> 5)) & 1) << 3;
      re += ((                 (symbol >> 3) ^ (symbol >> 5)) & 1) << 2;
      re += ((~(symbol >> 1) ^ (symbol >> 3) ^ (symbol >> 5)) & 1) << 1;
      re += 1;
      im  = ((                                 (symbol >> 4)) & 1) << 3;
      im += ((                 (symbol >> 2) ^ (symbol >> 4)) & 1) << 2;
      im += ((~(symbol >> 0) ^ (symbol >> 2) ^ (symbol >> 4)) & 1) << 1;
      im += 1;

#ifndef __SYNTHESIS__
      std::cout << "point " << symbol << ": x = " << re << " y = " << im << std::endl;
#endif
      iq.real(re);
      iq.imag(im);
    } //end of hardEncode

    static void hardDecode(const t_hard_in &hardIn, t_symbol &symbol) {
      t_iq_comp re, im;
      re = hardIn.real();
      im = hardIn.imag();
      symbol  = ( (                          (re >> 2) ) &  1 ) << 5;
      symbol += ( (                          (im >> 2) ) &  1 ) << 4;
      symbol += ( (              (re >> 1) ^ (re >> 2) ) &  1 ) << 3;
      symbol += ( (              (im >> 1) ^ (im >> 2) ) &  1 ) << 2;
      symbol += ( ( ~(re >> 0) ^ (re >> 1)             ) &  1 ) << 1;
      symbol += ( ( ~(im >> 0) ^ (im >> 1)             ) &  1 ) << 0;
#ifndef __SYNTHESIS__
      std::cout << "re = " << re*2+1 << " im = " << im*2+1 << " symbol = " << symbol << std::endl;
#endif
    } //end of hardDecode
  };

} // end namespace hls

#endif // HLS_DSP_COMMON_UTILS_H


