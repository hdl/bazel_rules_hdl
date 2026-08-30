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

#ifndef HLS_CONVOLUTION_ENCODER_H
#define HLS_CONVOLUTION_ENCODER_H

#include "hls/dsp/utils/hls_dsp_common_utils.h"
#include "ap_int.h"
#include <hls_stream.h>

namespace hls {

  // ===================================================================================================================
  // CONVOLUTION_ENCODER: Class definition
  // o Template parameters:
  //  - OutputWidth      : Defines number of bits in the output bus; 1 bit when Punctured=true and DualOutput=false, 2 bits when DualOutput=true, else OutputRate bits
  //  - Punctured        : When true, enables puncturing of data
  //  - DualOutput       : When true, enables dual outputs with punctured data
  //  - InputRate        : Defines numerator of code rate
  //  - OutputRate       : Defines denominator of code rate
  //  - ConstraintLength : The constraint length, K, is the number of registers in the encoder, plus one
  //  - PunctureCode0    : When Punctured=true, puncture code for output 0.  Length (in binary) must equal the puncture input rate.  Total number of 1's in both PunctureCode parameters equals the output rate.
  //  - PunctureCode1    : When Punctured=true, puncture code for output 1.  Length (in binary) must equal the puncture input rate.  Total number of 1's in both PunctureCode parameters equals the output rate.
  //  - ConvolutionCode0 : Convolution code for rates 1/2 to 1/7   -
  //  - ConvolutionCode1 : Convolution code for rates 1/2 to 1/7    |
  //  - ConvolutionCode2 : Convolution code for rates 1/3 to 1/7    |
  //  - ConvolutionCode3 : Convolution code for rates 1/4 to 1/7    | Length (in binary) for all convolution codes (if used) must equal the constraint length value.
  //  - ConvolutionCode4 : Convolution code for rates 1/5 to 1/7    |
  //  - ConvolutionCode5 : Convolution code for rates 1/6 to 1/7    |
  //  - ConvolutionCode6 : Convolution code for rate 1/7           -
template<
  int OutputWidth,
  bool Punctured,
  bool DualOutput,
  int InputRate,
  int OutputRate,
  int ConstraintLength,
  int PunctureCode0,
  int PunctureCode1,
  int ConvolutionCode0,
  int ConvolutionCode1,
  int ConvolutionCode2,
  int ConvolutionCode3,
  int ConvolutionCode4,
  int ConvolutionCode5,
  int ConvolutionCode6>
  class convolution_encoder {

 public:
  convolution_encoder() {

    // Set initial and reset values
    constraint_register = 0;
    puncture_count = 0;
    output_valid = 0;
    output_valid_count = 0;

    // Store convolution codes in an array which may be loop indexed
    convolution_codes[0] = ConvolutionCode0;
    convolution_codes[1] = ConvolutionCode1;
    convolution_codes[2] = ConvolutionCode2;
    convolution_codes[3] = ConvolutionCode3;
    convolution_codes[4] = ConvolutionCode4;
    convolution_codes[5] = ConvolutionCode5;
    convolution_codes[6] = ConvolutionCode6;

    // Similarly for puncture codes, store in array
    puncture_codes[0] = PunctureCode0;
    puncture_codes[1] = PunctureCode1;

    // Verify that template parameters are correct in simulation
    check_params();

  } // end constructor

  ~convolution_encoder() {
  } // end destructor

  // ===================================================================================================================
  // CONVOLUTION_ENCODER: Entry point function.
  // o Arguments:
  //  - inputData        : Single-bit datastream to be encoded
  //  - outputData       : Encoded datastream; OutputRate-bits wide unless Punctured=true (1-bit wide) or DualOutput=true (2-bits wide)
  void operator()(stream< ap_uint<1> > &inputData,
                  stream< ap_uint<OutputWidth> > &outputData) {

      Function_convolution_encoder_operator:;

      encode(inputData, outputData);

    }; // operator()


 private:

  // Shared constants
  static const int MAX_CONVOLUTION_CODES = 7;
  static const int MAX_PUNCTURE_CODES = 2;

  // Utility template functions
  struct EncoderOutputWidth {
    enum { width = (Punctured ? 2 : OutputWidth) };
  };

  struct PunctureRegisterStages {
    enum { stages = (DualOutput ? 2*InputRate : InputRate) };
  };

  struct PunctureCountMax {
    enum { max = (DualOutput ? (2*InputRate)-1 : OutputRate-1) };
  };

  // State variables
  ap_uint<ConstraintLength-1> constraint_register;
  ap_uint<EncoderOutputWidth::width> puncture_register[PunctureRegisterStages::stages]; // No reset required
  ap_uint<OutputWidth> output_register[OutputRate]; // No reset required
  ap_uint<bitstorepresent<PunctureCountMax::max>::bits> puncture_count;
  ap_uint<1> output_valid;
  ap_uint<bitstorepresent<PunctureRegisterStages::stages>::bits> output_valid_count;

  // These arrays are considered constant, and are initialized in the constructor
  ap_uint<ConstraintLength> convolution_codes[MAX_CONVOLUTION_CODES];
  ap_uint<InputRate> puncture_codes[MAX_PUNCTURE_CODES];

  void check_params() {
    // Verify that template parameters are correct in simulation
    #ifndef __SYNTHESIS__
    if (ConstraintLength < 3 || ConstraintLength > 9) {
      std::cout << "ERROR: " << __FILE__ << ": ConstraintLength must be 3 to 9" << std::endl;
      exit(1);
    }
    if (Punctured) {
      if (DualOutput && OutputWidth != 2) {
        std::cout << "ERROR: " << __FILE__ << ": OutputWidth must be 2 for a punctured encoder with dual output" << std::endl;
        exit(1);
      }
      if (!DualOutput && OutputWidth != 1) {
        std::cout << "ERROR: " << __FILE__ << ": OutputWidth must be 1 for a punctured encoder without dual output" << std::endl;
        exit(1);
      }
      if (InputRate < 2 || InputRate > 12) {
        std::cout << "ERROR: " << __FILE__ << ": InputRate must be 2 to 12" << std::endl;
        exit(1);
      }
      if (OutputRate < InputRate+1 || OutputRate > (2*InputRate)-1) {
        std::cout << "ERROR: " << __FILE__ << ": OutputRate must be InputRate+1 to (2*InputRate)-1" << std::endl;
        exit(1);
      }
      // Check the puncturing codes are valid
      int bits_set = 0;
      puncture_code_loop: for (int j=0; j<MAX_PUNCTURE_CODES; j++) {
        int code = puncture_codes[j];
        input_rate_loop: for (int i=0; i<InputRate; i++) {
          if (code % 2 == 1) {
            bits_set++;
          }
          code /= 2;
          if (code <= 0) {
            break;
          }
        }
      }
      if (bits_set != OutputRate) {
        std::cout << "ERROR: " << __FILE__ << ": Puncture codes are incorrect.  Binary length of each code must equal InputRate, number of bits set must equal OutputRate" << std::endl;
        exit(2);
      }
    } else {
      if (OutputWidth != OutputRate) {
        std::cout << "ERROR: " << __FILE__ << ": OutputWidth must equal OutputRate" << std::endl;
        exit(1);
      }
      if (InputRate > 1) {
        std::cout << "ERROR: " << __FILE__ << ": InputRate must be 1" << std::endl;
        exit(1);
      }
      if (OutputRate < 2 || OutputRate > 7) {
        std::cout << "ERROR: " << __FILE__ << ": OutputRate must be 2 to 7" << std::endl;
        exit(1);
      }
      if (DualOutput) {
        std::cout << "ERROR: " << __FILE__ << ": Dual Output is only supported when Puncturing is used" << std::endl;
        exit(1);
      }
    }
    #endif
  }; // check_params

  // Core function.  Performs convolutional encoding of a datastream, with optional puncturing
  void encode(stream< ap_uint<1> > &inputData,
              stream< ap_uint<OutputWidth> > &outputData) {

    Function_convolution_encoder_encode:;

    // Optimal resources and throughput are achieved when pipelined
    // Estimated resources are slightly lower when the directive is placed here
    #pragma HLS PIPELINE II=1

    // Ensure state variables are reset
    #pragma HLS RESET variable=constraint_register
    #pragma HLS RESET variable=puncture_count
    #pragma HLS RESET variable=output_valid
    #pragma HLS RESET variable=output_valid_count

    // Flatten puncture register to achieve II=1
    #pragma HLS ARRAY_PARTITION variable=puncture_register complete

    ap_uint<1> encoder_in;
    ap_uint<EncoderOutputWidth::width> encoded_data;

    if (!Punctured || DualOutput || puncture_count < InputRate) {
      encoder_in = inputData.read();

      // Perform encoding
      encode_loop: for (int i=0; i< EncoderOutputWidth::width; i++) {
        ap_uint<ConstraintLength> tmpData = (constraint_register,encoder_in); // temporary variable allows use of .reverse()
        encoded_data[i] = (tmpData.reverse() & (convolution_codes[i])).xor_reduce();
      }

      if (!Punctured) {
        // Output data directly
        outputData << encoded_data;
      } else {
        // Write into puncture register for puncturing operation
        puncture_register_loop: for (int i=PunctureRegisterStages::stages-1; i>0; i--) {
          puncture_register[i] = puncture_register[i-1];
        }
        puncture_register[0] = encoded_data;
      }

      // Shift contraint register for next cycle
      constraint_register = (constraint_register,encoder_in);
    }

    if (Punctured) {

    /*
      In the punctured configuration, the basic convolution encoder is always a rate 1/2 encoder, with two bits output for
      every one bit input. After the encoding, certain bits of the rate 1/2 encoded data are punctured (or deleted) and not
      transmitted.  Thus, for a rate 3/4 punctured encoder, for every three input bits, only four of the six encoded bits generated
      by the encoder are actually transmitted.

      The single-output puncturing mode outputs more data than was input.  The dual-output puncturing mode outputs less
      data than was input.  In both cases, some rate control is required, which is implemented with the output_valid signal.
    */

      if (!DualOutput) {

        if (puncture_count == InputRate) {

          // Do puncturing
          int k=OutputRate-1;
          single_punc_outer_loop: for (int i=InputRate-1; i>=0; i--) {
            single_punc_inner_loop: for (int j=0; j<MAX_PUNCTURE_CODES; j++) {
              if (puncture_codes[j][i] == 1) {
                output_register[k][0] = puncture_register[i][j];
                k--;
              }
            }
          }

        } else {

          // Shift data for output
          single_shift_loop: for (int i=OutputRate-1; i>0; i--) {
            output_register[i][0] = output_register[i-1][0];
          }
          output_register[0][0] = 0;
        }

        if (output_valid == 1) {
          outputData << output_register[OutputRate-1][0];
        }

      } else { // DualOutput

        if (puncture_count == PunctureCountMax::max) {

          // Do puncturing
          int row = 0;
          int col = OutputRate-1;
          dual_width_loop: for (int i=OutputWidth-1; i>=0; i--) {
            int offset = i*InputRate;
            dual_punc_outer_loop: for (int j=InputRate-1; j>=0; j--) {
              dual_punc_inner_loop: for (int k=0; k<MAX_PUNCTURE_CODES; k++) {
                if (puncture_codes[k][j] == 1) {
                  output_register[col][row] = puncture_register[j+offset][k];
                  col = col-row;
                  row = 1-row;
                }
              }
            }
          }

        } else {

          if (output_valid == 1) {
            outputData << output_register[OutputRate-1];
          }

          // Shift data for output
          dual_shift_loop: for (int i=OutputRate-1; i>0; i--) {
            output_register[i] = output_register[i-1];
          }
          output_register[0] = 0;

        }

      } // DualOutput

      // Master counter to track puncturing status
      if (puncture_count == PunctureCountMax::max) {
        puncture_count = 0;
      } else {
        puncture_count++;
      }

      // Output valid flag controls writes to output FIFO
      if (output_valid_count == PunctureRegisterStages::stages-1) {
        output_valid_count = PunctureRegisterStages::stages-1;
        output_valid = 1;
      } else {
        output_valid_count++;
      }

    } // Punctured

  } // encode

  }; // end class convolution_encoder

} // end namespace hls

#endif // HLS_CONVOLUTION_ENCODER_H



