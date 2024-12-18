/* autopilot_apint.h*/
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

 *
 * $Id$
 */

#ifndef _AUTOPILOT_APINT_H_
#define _AUTOPILOT_APINT_H_

#include "etc/autopilot_dt.h"
#include "etc/autopilot_ssdm_bits.h"

#define APInt_BitWidthOf(X) _ssdm_op_bitwidthof(X)

#define APInt_Concatenate(X, Y) _ssdm_op_Concat(X, Y)
#define APInt_GetBit(Val, Bit) _ssdm_op_GetBit(Val, Bit)
#define APInt_SetBit(Val, Bit, Repl) _ssdm_op_SetBit(Val, Bit, Repl)
#define APInt_GetRange(Val, Hi, Lo) _ssdm_op_GetRange(Val, Hi, Lo)
#define APInt_SetRange(Val, Hi, Lo, Repl) _ssdm_op_SetRange(Val, Hi, Lo, Repl)

#define APInt_AndReduce(X) _ssdm_op_reduce(and, X)
#define APInt_NandReduce(X) _ssdm_op_reduce(nand, X)
#define APInt_OrReduce(X) _ssdm_op_reduce(or, X)
#define APInt_NorReduce(X) _ssdm_op_reduce(nor, X)
#define APInt_XorReduce(X) _ssdm_op_reduce(xor, X)
#define APInt_XnorReduce(X) _ssdm_op_reduce(nxor, X)

#define APInt_BitsFromString(Str, Bits) \
    _ssdm_op_bitsFromString(Str, Bits)
#define APInt_BitsFromHexString(Str, Bits) \
    _ssdm_op_bitsFromHexString(Str, Bits)
#define APInt_BitsFromOctalString(Str, Bits) \
    _ssdm_op_bitsFromOctalString(Str, Bits)
#define APInt_BitsFromBinaryString(Str, Bits) \
    _ssdm_op_bitsFromBinaryString(Str, Bits)


/************************************************/

#define apint_bitwidthof(X) _ssdm_op_bitwidthof(X)

#define apint_concatenate(X, Y) _ssdm_op_Concat(X, Y)
#define apint_get_bit(Val, Bit) _ssdm_op_GetBit(Val, Bit)
#define apint_set_bit(Val, Bit, Repl) _ssdm_op_SetBit(Val, Bit, Repl)
#define apint_get_range(Val, Hi, Lo) _ssdm_op_GetRange(Val, Hi, Lo)
#define apint_set_range(Val, Hi, Lo, Repl) _ssdm_op_SetRange(Val, Hi, Lo, Repl)

#define apint_and_reduce(X) _ssdm_op_reduce(and, X)
#define apint_nand_reduce(X) _ssdm_op_reduce(nand, X)
#define apint_or_reduce(X) _ssdm_op_reduce(or, X)
#define apint_nor_reduce(X) _ssdm_op_reduce(nor, X)
#define apint_xor_reduce(X) _ssdm_op_reduce(xor, X)
#define apint_xnor_reduce(X) _ssdm_op_reduce(nxor, X)

#define apint_print(Val, Radix) _ssdm_op_print_apint(Val, Radix)
#define apint_fprint(FileOut, Val, Radix) _ssdm_op_fprint_apint(FileOut, Val, Radix)

#define apint_vstring2bits_hex(Str, Bits) _ssdm_op_sscan_hex_apint(Str, Bits)
#define apint_string2bits_dec(Str, Bits) _ssdm_op_bitsFromString(Str, Bits)
#define apint_string2bits_hex(Str, Bits) _ssdm_op_bitsFromHexString(Str, Bits)
#define apint_string2bits_oct(Str, Bits) _ssdm_op_bitsFromOctalString(Str, Bits)
#define apint_string2bits_bin(Str, Bits) _ssdm_op_bitsFromBinaryString(Str, Bits)
#define apint_string2bits(Str, Bits) apint_string2bits_dec(Str, Bits)

#endif


