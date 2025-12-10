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

#ifndef HLS_QAM_DEMOD_H
#define HLS_QAM_DEMOD_H

#include "ap_int.h"
#include <hls_stream.h>
#include <complex>
#include "hls/dsp/utils/hls_dsp_common_utils.h"

namespace hls {
#if (defined(InputWidth) ||                     \
     defined(Constellation))
#error One or more of the template parameters used by this function is already defined and will cause a conflict
#endif

  // ===================================================================================================================
  // QAM DEMODULATOR: Class definition
  // o Template parameters:
  //  - Constellation : Selects the QAM modulation scheme to be used (QPSK, QAM16, etc)
  //  - InputWidth    : Number of bits in each scalar component of the complex t_in input.
  // The qam_mod block performs I/Q to symbol mapping of a hard decision QAM decoder.
  template<
    class Constellation,
    int InputWidth>
    class qam_demod {

  public:

      typedef ap_int< InputWidth > t_incomponent;
      typedef std::complex< t_incomponent > t_in;

      qam_demod() {
        // Verify that template parameters are correct in simulation
        check_params();
      }; // end constructor

      ~qam_demod() {
      }; //end destructor

      //Utilities
      //static function - owned by class not object since return value doesn't vary by object
      static int get_symbol_width() {
        return Constellation::SYMBOL_WIDTH;
      }

      // ===================================================================================================================
      // QAM DEMODULATOR: Entry point function
      // o Arguments:
      //  - inputData     : type t_in. This is a complex IQ input signal.
      //  - symbol        : type t_symbol. This is an N-bit symbol determined as the closest match to the input IQ signal
      void operator()(const t_in &inputData,
                      typename Constellation::t_symbol &symbol ) {

      Function_qam_demod_operator:;

        //take leading bits of input data
        typename Constellation::t_hard_in hardIn;

        const int shift = InputWidth-Constellation::SYMBOL_WIDTH/2;

        hardIn.real(inputData.real() >> shift);
        hardIn.imag(inputData.imag() >> shift);

        Constellation::hardDecode(hardIn, symbol);

      } // operator()

  private:
      static const int MAX_INPUT_WIDTH = 16;

      void check_params() {
        // Verify that template parameters are correct in simulation
        #ifndef __SYNTHESIS__
        if (InputWidth > MAX_INPUT_WIDTH ) {
          std::cout << "ERROR: " << __FILE__ << ": InputWidth must be " << MAX_INPUT_WIDTH << " or less" << std::endl;
          exit(1);
        }
        if (InputWidth < Constellation::STAR_WIDTH && Constellation::QAMTYPE == 0) {
          std::cout << "ERROR: " << __FILE__ << ": InputWidth must be at least " << Constellation::STAR_WIDTH << " for QPSK" << std::endl;
          exit(1);
        }
        if (InputWidth < Constellation::STAR_WIDTH && Constellation::QAMTYPE == 1) {
          std::cout << "ERROR: " << __FILE__ << ": InputWidth must be at least " << Constellation::STAR_WIDTH << " for QAM16" << std::endl;
          exit(1);
        }
        if (InputWidth < Constellation::STAR_WIDTH && Constellation::QAMTYPE == 2) {
          std::cout << "ERROR: " << __FILE__ << ": InputWidth must be at least " << Constellation::STAR_WIDTH << " for QAM64" << std::endl;
          exit(1);
        }
        #endif
      } //end of check_params

    }; // qam_demod

} // end namespace hls

#endif // HLS_QAM_DEMOD_H


