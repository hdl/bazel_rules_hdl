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

#ifndef HLS_QAM_MOD_H
#define HLS_QAM_MOD_H

#include "ap_int.h"
#include <hls_stream.h>
#include <complex>
#include "hls/dsp/utils/hls_dsp_common_utils.h"

namespace hls {
#if (defined(OutputWidth) ||                    \
     defined(Constellation))
#error One or more of the template parameters used by this function is already defined and will cause a conflict
#endif

  // ===================================================================================================================
  // QAM MODULATOR: Class definition
  // o Template parameters:
  //  - Constellation : Selects the QAM modulation scheme to be used (QPSK, QAM16, etc)
  //  - OutputWidth   : Number of bits in each scalar component of the complex t_iq output.
  // The qam_mod block performs symbol to I/Q mapping as used in a QAM encoder. The output is zero extended up to the OutputWidth template parameter
  template<
    class Constellation,
    int OutputWidth>
    class qam_mod {

  public:

      typedef ap_int< OutputWidth > t_outcomponent;
      typedef std::complex< t_outcomponent > t_iq;

      qam_mod() {
        check_params();
      };//end of constructor

      ~qam_mod() {
      }; //end of destructor

      //Utilities
      //static function - owned by class not object since return value doesn't vary by object
      static int get_symbol_width() {
        return Constellation::SymbolWidth;
      }

      // ===================================================================================================================
      // QAM MODULATOR: Entry point function
      // o Arguments:
      //  - symbol        : type t_symbol. This is an N-bit symbol to be iq encoded. N is determined by the choice of QAM modulation scheme.
      //  - outputData    : type t_iq. This is a complex IQ output signal.
      void operator()(const typename Constellation::t_symbol &symbol,
                      t_iq &outputData) {

      Function_qam_mod_operator:;

        typename Constellation::t_star iq;

        Constellation::hardEncode(symbol,iq);
        outputData.real((t_outcomponent)iq.real() << (OutputWidth-Constellation::STAR_WIDTH));
        outputData.imag((t_outcomponent)iq.imag() << (OutputWidth-Constellation::STAR_WIDTH));
      } // operator()

  private:
      static const int MAX_OUTPUT_WIDTH = 16;

      Constellation asterism;

      void check_params() {
        // Verify that template parameters are correct in simulation
        #ifndef __SYNTHESIS__
        if (OutputWidth < Constellation::STAR_WIDTH || OutputWidth > MAX_OUTPUT_WIDTH) {
          std::cout << "ERROR: " << __FILE__ << ": OutputWidth must be between " << Constellation::STAR_WIDTH << " and " << MAX_OUTPUT_WIDTH << std::endl;
          exit(1);
        }
        #endif
      } //end of check_params

    }; // qam_mod

} //end namespace hls

#endif // HLS_QAM_MOD_H


