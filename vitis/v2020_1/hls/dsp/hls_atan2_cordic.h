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

#ifndef HLS_ATAN2_CORDIC_H
#define HLS_ATAN2_CORDIC_H

#include "hls/dsp/utils/hls_cordic.h"

namespace hls {

  // ===================================================================================================================
  // Input and output interfaces
  template <int InputWidth> struct atan2_input {
    typedef cordic_inputs<InputWidth,CORDIC_F_ATAN,CORDIC_FORMAT_SIG_FRAC> cartesian;
  };

  template <int OutputWidth> struct atan2_output {
    typedef cordic_outputs<OutputWidth,CORDIC_F_ATAN,CORDIC_FORMAT_SIG_FRAC> phase;
  };

  // ===================================================================================================================
  // ATAN2: Entry point function.
  // o Template parameters:
  //  - PhaseFormat      : Selects whether the phase is expressed in radians or scaled radians (pi * 1 radian)
  //  - InputWidth       : Defines overall input data width
  //  - OutputWidth      : Defines overall output data width
  //  - RoundMode        : Selects the rounding mode to apply to the output data
  // o Arguments:
  //  - x                : Input data with two integer bits and InputWidth-2 fractional bits, in the range [-1,1]
  //  - atanX            : Four quadrant arctangent of x with three integer bits and OutputWidth-3 fractional bits, in the range [-1,1]
  // o The internal CORDIC function applies its own rounding, therefore the interface
  //   ap_fixed types need not specify rounding and saturation modes
  template <
    int PhaseFormat,
    int InputWidth,
    int OutputWidth,
    int RoundMode
    > void atan2(const typename atan2_input<InputWidth>::cartesian &x,
                 typename atan2_output<OutputWidth>::phase &atanX) {

    Function_atan2_cordic:;

    cordic_base<
      CORDIC_F_ATAN,
      CORDIC_TRUE, // CoarseRotate always enabled for atan2
      CORDIC_FORMAT_SIG_FRAC,
      PhaseFormat,
      InputWidth,
      OutputWidth,
      CORDIC_ITER_AUTO,
      CORDIC_PREC_AUTO,
      RoundMode,
      CORDIC_SCALE_NONE>(x, atanX);
    }

} // end namespace hls

#endif // HLS_ATAN2_CORDIC_H


