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

#ifndef HLS_VITERBI_DECODER_H
#define HLS_VITERBI_DECODER_H

#include "hls/dsp/utils/hls_dsp_common_utils.h"
#include "ap_int.h"
#include <hls_stream.h>

namespace hls {

  // ===================================================================================================================
  // Viterbi Decoder input data structure
  //
  // Base template
  template<int OutputRate, int InputDataWidth, bool HasEraseInput> struct viterbi_decoder_input {
    ap_uint<OutputRate*InputDataWidth> data;
  };

  // Specialization for soft data with erasures
  template<int OutputRate, int InputDataWidth> struct viterbi_decoder_input<OutputRate, InputDataWidth, true> {
    ap_uint<OutputRate*InputDataWidth> data;
    ap_uint<OutputRate> erase;
  };

  // Specialization for soft data with no erasures, or hard data
  template<int OutputRate, int InputDataWidth> struct viterbi_decoder_input<OutputRate, InputDataWidth, false> {
    ap_uint<OutputRate*InputDataWidth> data;
  };


  // ===================================================================================================================
  // VITERBI_DECODER: Class definition
  // o Template parameters:
  //  - ConstraintLength   : The constraint length, K.  Supported range is 3 to 9.
  //  - TracebackLength    : Number of states to trace back through the trellis during decoding.  Use at least 6x ConstraintLength, or at least 12x ConstraintLength for punctured codes
  //  - HasEraseInput      : When true, an Erase input is present on the core to flag erasures (null symbols) in a punctured code
  //  - SoftData           : When true, the function accepts soft (multi-bit) input data
  //  - InputDataWidth     : Specifies width of the input data; set to 1 for hard data, 3-5 for soft data
  //  - SoftDataFormat     : Specifies soft data formatting; 0 -> Signed Magnitude, 1 -> Offset Binary
  //  - OutputRate         : Specifies output rate of the matching convolution encoder.  Determines number of inputs buses for decoder.
  //  - ConvolutionCode0   : Convolution code for rates 1/2 to 1/7   -
  //  - ConvolutionCode1   : Convolution code for rates 1/2 to 1/7    |
  //  - ConvolutionCode2   : Convolution code for rates 1/3 to 1/7    |
  //  - ConvolutionCode3   : Convolution code for rates 1/4 to 1/7    | Length (in binary) for all convolution codes (if used) must equal the constraint length value.
  //  - ConvolutionCode4   : Convolution code for rates 1/5 to 1/7    |
  //  - ConvolutionCode5   : Convolution code for rates 1/6 to 1/7    |
  //  - ConvolutionCode6   : Convolution code for rate 1/7           -
  template<
    int ConstraintLength,
    int TracebackLength,
    bool HasEraseInput,
    bool SoftData,
    int InputDataWidth,
    int SoftDataFormat,
    int OutputRate,
    int ConvolutionCode0,
    int ConvolutionCode1,
    int ConvolutionCode2,
    int ConvolutionCode3,
    int ConvolutionCode4,
    int ConvolutionCode5,
    int ConvolutionCode6>
    class viterbi_decoder {

  public:

      viterbi_decoder() {

        // Verify that template parameters are correct in simulation
        check_params();

        // Define ACS connectivity
        costs_index_outer_loop : for (int state=0; state<number_of_states::states; state++) {
          costs_index_inner_loop : for (int branch=0; branch<BRANCHES; branch++) {
            bmu_costs_index[state][branch] = bmu_result(state,branch);
            input_costs_index[state][branch] = previous_branch(state,branch);
          }
        }

        // Set initial/reset values for variables holding state
        path_metrics_init_loop : for (int state=0; state<number_of_states::states; state++) {
          path_metrics[state] = 0;
        }
        base_count = 0;
        write_and_output_addr = 0;
        traceback_addr = 2*TracebackLength;
        reg_write_and_output_addr = 2*TracebackLength;
        block_count = 0;
        output_valid = 0;
        decode_bit = 0;
        traceback_bit = 0;
        decode_state = 0;
        traceback_state = 0;
        output_valid_count = 0;
        reg_decode_write = 0;
        reg_traceback_write = 0;
        norm_sr_init_loop : for (int bit=0; bit<2; bit++) {
          norm_sr[bit] = 0;
        }
        norm_reg = 0;
      } // end constructor


      ~viterbi_decoder() {
      } // end destructor

      // ===================================================================================================================
      // VITERBI_DECODER: Entry point function.
      // o Arguments:
      //  - inputData        : Convolution-encoded datastream, with accompanying Erase signals if a punctured code is used.
      //                       Data bus is OutputRate*InputDataWidth-bits wide, Erase bus is OutputRate bits wide.
      //  - outputData       : Decoded single-bit datastream
      void operator()(stream< viterbi_decoder_input<OutputRate,InputDataWidth,HasEraseInput> > &inputData,
                      stream< ap_uint<1> > &outputData) {

        Function_viterbi_decoder_operator:;

        decode(inputData, outputData);

      }; // operator()

  private:

      // Calculation of internal widths and parameters which are instance-specific
      struct bmu_output_width {
        enum { width = (SoftData == 1 ? bitstorepresent< ((1 << (InputDataWidth))-1) * OutputRate >::bits : 3) };
      };

      struct acs_width {
        enum { width = InputDataWidth + OutputRate + 3 - 2 + (ConstraintLength >= 8 ? 1 : 0) };
      };

      struct block_depth_x3 {
        enum { depth = 3 * TracebackLength };
      };

      struct state_bits {
        enum { bits = ConstraintLength-1 };
      };

      struct number_of_states {
        enum { states = 1 << state_bits::bits };
      };

      struct GetBmuCostsMemEntries {
        enum { entries = 1 << OutputRate };
      };

      // Constants for SoftDataFormat
      static const int OFFSET_BINARY = 1;
      static const int SIGNED_MAGNITUDE = 0;

      static const int BRANCHES = 2;
      static const int TOTAL_BLOCKS = 6; // Six addressing blocks are used

      // Thresholds for address generators
      static const int WRITE_BLOCK_COUNT_THRESH = 2;
      static const int TRACEBACK_BLOCK_COUNT_THRESH = 4;

      // Latency (input samples required) before an output is available
      static const int DATA_VALID_LATENCY = (4*TracebackLength)+ConstraintLength-1;

      // These (effectively constant) variables store the indices for connecting the ACS units, and are initialized in the constructor
      // The do not generate any logic - they are simply lookups which degenerate to wiring when the ACS units are connected.
      int bmu_costs_index[number_of_states::states][BRANCHES];
      int input_costs_index[number_of_states::states][BRANCHES];

      // State variables
      ap_uint< acs_width::width > path_metrics[number_of_states::states];
      ap_uint<number_of_states::states + 1> traceback_memory[1 << bitstorepresent< block_depth_x3::depth >::bits];
      ap_uint<number_of_states::states + 1> lifo_memory[1 << bitstorepresent< block_depth_x3::depth >::bits];
      ap_uint< bitstorepresent<TracebackLength-1>::bits > base_count;
      ap_uint< bitstorepresent< block_depth_x3::depth >::bits > write_and_output_addr, traceback_addr, reg_write_and_output_addr;
      ap_uint< bitstorepresent<TOTAL_BLOCKS>::bits > block_count;
      ap_uint<1> output_valid, decode_bit, traceback_bit, norm_sr[2], norm_reg;
      ap_uint<state_bits::bits> traceback_state, decode_state;
      ap_uint< bitstorepresent< (4*TracebackLength)+ConstraintLength-1 >::bits > output_valid_count;
      ap_uint< number_of_states::states +1 > reg_decode_write, reg_traceback_write;

      void check_params() {
        // Verify that template parameters are correct in simulation
        #ifndef __SYNTHESIS__

        if (ConstraintLength < 3 || ConstraintLength > 9) {
          std::cout << "ERROR: " << __FILE__ << ": ConstraintLength must be 3 to 9" << std::endl;
          exit(1);
        }
        if (TracebackLength < 12) {
          std::cout << "ERROR: " << __FILE__ << ": TracebackLength must be at least 12" << std::endl;
          exit(1);
        }
        if (HasEraseInput && (SoftData == 0)) {
          std::cout << "ERROR: " << __FILE__ << ": Puncturing/Erasure can only be used with soft data" << std::endl;
          exit(1);
        }
        if (OutputRate < 2 || OutputRate > 7) {
          std::cout << "ERROR: " << __FILE__ << ": OutputRate must be 3 to 7" << std::endl;
          exit(1);
        }
        if (SoftData > 0) {
          if (InputDataWidth < 3 || InputDataWidth > 5) {
            std::cout << "ERROR: " << __FILE__ << ": InputDataWidth must be 3 to 5" << std::endl;
            exit(1);
          }
        }
        switch (OutputRate) {
        case 2:
          if (ConvolutionCode0 == 0 ||
              ConvolutionCode1 == 0) {
            std::cout << "ERROR: " << __FILE__ << ": a required ConvolutionCode value is zero" << std::endl;
            exit(1);
          }
          break;
        case 3:
          if (ConvolutionCode0 == 0 ||
              ConvolutionCode1 == 0 ||
              ConvolutionCode2 == 0) {
            std::cout << "ERROR: " << __FILE__ << ": a required ConvolutionCode value is zero" << std::endl;
            exit(1);
          }
          break;
        case 4:
          if (ConvolutionCode0 == 0 ||
              ConvolutionCode1 == 0 ||
              ConvolutionCode2 == 0 ||
              ConvolutionCode3 == 0) {
            std::cout << "ERROR: " << __FILE__ << ": a required ConvolutionCode value is zero" << std::endl;
            exit(1);
          }
          break;
        case 5:
          if (ConvolutionCode0 == 0 ||
              ConvolutionCode1 == 0 ||
              ConvolutionCode2 == 0 ||
              ConvolutionCode3 == 0 ||
              ConvolutionCode4 == 0) {
            std::cout << "ERROR: " << __FILE__ << ": a required ConvolutionCode value is zero" << std::endl;
            exit(1);
          }
          break;
        case 6:
          if (ConvolutionCode0 == 0 ||
              ConvolutionCode1 == 0 ||
              ConvolutionCode2 == 0 ||
              ConvolutionCode3 == 0 ||
              ConvolutionCode4 == 0 ||
              ConvolutionCode5 == 0) {
            std::cout << "ERROR: " << __FILE__ << ": a required ConvolutionCode value is zero" << std::endl;
            exit(1);
          }
          break;
        case 7:
          if (ConvolutionCode0 == 0 ||
              ConvolutionCode1 == 0 ||
              ConvolutionCode2 == 0 ||
              ConvolutionCode3 == 0 ||
              ConvolutionCode4 == 0 ||
              ConvolutionCode5 == 0 ||
              ConvolutionCode6 == 0) {
            std::cout << "ERROR: " << __FILE__ << ": a required ConvolutionCode value is zero" << std::endl;
            exit(1);
          }
          break;
        default:
          std::cout << "ERROR: " << __FILE__ << ": OutputRate is out of range" << std::endl;
          exit(1);
        }

        #endif
      }; //end of function check_params


      // Overloaded templated functions to hide .erase struct member when erasures are not implemented
      template <int outputrate, int softwidth> ap_uint<1> get_erase_bit(int i, viterbi_decoder_input<outputrate,softwidth,true> d) {
      Function_viterbi_decoder_erase_bit_has_erase:;
        ap_uint<1> e = d.erase[i];
        return e;
      }

      template <int outputrate, int softwidth> ap_uint<1> get_erase_bit(int i, viterbi_decoder_input<outputrate,softwidth,false> d) {
      Function_viterbi_decoder_get_erase_bit_no_erase:;
        return 0;
      }

      // ===================================================================================================================
      // Utility functions

      // Count the number of 1's to determine the Hamming distance
      template <int adderoutputwidth> ap_uint<adderoutputwidth> count_ones(ap_uint<OutputRate> vec) {
      Function_viterbi_decoder_count_ones:;
        ap_uint<adderoutputwidth> sum = 0;
        count_ones_loop : for (int i=0; i<OutputRate; i++) {
          sum += vec[i];
        }
        return sum;
      };

      // Compute previous branch ACS output to use for the next ACS
      int previous_branch(int state_count, int branch_count) {
      Function_viterbi_decoder_previous_branch:;
        const int shift_top = 1 << (ConstraintLength-2);
        const int shift = 2;
        int result = branch_count*shift_top + (state_count/shift);
        return result;
      };

      // Compute result to use from BMU for a given ACS
      int bmu_result(int state_count, int branch_count) {
      Function_viterbi_decoder_bmu_result:;
        const int shift_top = 1 << (ConstraintLength-1);
        int convolve_logic = 0;
        int output_from_path = 0;
        ap_uint<ConstraintLength> constraint_reg = 0;
        ap_uint<1> output_bit = 0;
        int res = 0;
        int const_reg = 0;

        // Build array of codes which we can loop over
        // Maximally-size this; we'll use just the codes required, and use the LSBs of each
        // The user can specify the codes in the radix they require, and store them in the int template parameters
        const int MAX_CODES = 7;
        ap_uint<ConstraintLength> codes[MAX_CODES] = {ConvolutionCode0,ConvolutionCode1,ConvolutionCode2,ConvolutionCode3,ConvolutionCode4,ConvolutionCode5,ConvolutionCode6};

        code_reverse_loop : for (int i=0; i<MAX_CODES; i++) {
          codes[i] = codes[i].reverse(); // Reverse the convolution codes to match the convolution encoder
        }

        const_reg = (branch_count*shift_top)+state_count;
        constraint_reg = const_reg;
        convolution_outer_loop : for (int i=0; i<OutputRate; i++) {
          convolve_logic = codes[i];
          output_bit = 0;
          convolution_inner_loop : for (int bit=0; bit<ConstraintLength; bit++) {
            if (convolve_logic % 2 != 0) {
              output_bit ^= constraint_reg[bit];
            }
            convolve_logic /= 2;
          }
          if (output_bit == 1) {
            output_from_path += (1 << i);
          }
        }
        return output_from_path;
      };

      // ===================================================================================================================
      // Function performing Viterbi decoding
      void decode(stream< viterbi_decoder_input<OutputRate,InputDataWidth,HasEraseInput> > &inputData,
                  stream< ap_uint<1> > &outputData) {

        Function_viterbi_decoder_decode:;

        // Internal variables not holding state
        viterbi_decoder_input<OutputRate,InputDataWidth,HasEraseInput> decoder_in;
        ap_uint<InputDataWidth> din[OutputRate], din_formatted[OutputRate];
        ap_uint<OutputRate> erase;
        ap_uint< bmu_output_width::width > bmu_costs[GetBmuCostsMemEntries::entries];
        ap_uint< acs_width::width > input_costs[number_of_states::states];
        ap_uint< number_of_states::states > path_from_acs, decode;
        ap_uint< number_of_states::states +1 > traceback_write, decode_write, traceback_read, decode_read;
        ap_uint< number_of_states::states > traceback;
        ap_uint< bitstorepresent< block_depth_x3::depth >::bits > traceback_fbk, traceback_incr, write_fbk, write_incr, offset_wr, offset_traceback;
        ap_uint< number_of_states::states > norm_check = 0;
        ap_uint<1> lifo_out, output_valid_count_incr, base_count_tc;
        ap_uint<1> norm = 0;
        ap_uint<1> normalize = 0;

        // Force function pipelining to permit full-throughput streaming operation
        #pragma HLS PIPELINE II=1

        // Ensure state variables are reset to initial values set up in the constructor
        #pragma HLS RESET variable=path_metrics
        #pragma HLS RESET variable=base_count
        #pragma HLS RESET variable=write_and_output_addr
        #pragma HLS RESET variable=traceback_addr
        #pragma HLS RESET variable=block_count
        #pragma HLS RESET variable=decode_state
        #pragma HLS RESET variable=traceback_state
        #pragma HLS RESET variable=decode_bit
        #pragma HLS RESET variable=traceback_bit
        #pragma HLS RESET variable=output_valid_count
        #pragma HLS RESET variable=output_valid
        #pragma HLS RESET variable=norm_reg
        #pragma HLS RESET variable=norm_sr

        // Ensure path_metrics array is implemented as 1 register per ACS
        // which is relevant when reset is implemented
        #pragma HLS ARRAY_PARTITION variable=path_metrics complete

        // Ensure normalization shift register is implemented as registers, rather than a RAM with reset
        #pragma HLS ARRAY_PARTITION variable=norm_sr complete

        // Required to achieve II=1 when pipelined
        #pragma HLS DEPENDENCE variable=traceback_memory inter false
        #pragma HLS DEPENDENCE variable=lifo_memory inter false

        // TIP: Comment-in or set these directives from Tcl to force use of Block RAM for decoder memories
        // Small constraint lengths will tend to use distributed memory, larger constraint lengths Block RAM
        //#pragma HLS RESOURCE variable=traceback_memory core=RAM_2P_BRAM
        //#pragma HLS RESOURCE variable=lifo_memory core=RAM_2P_BRAM

        // Flatten input arrays to achieve II=1 and ensure only a register is synthesized
        #pragma HLS ARRAY_PARTITION variable=input_costs complete dim=0
        #pragma HLS ARRAY_PARTITION variable=bmu_costs complete dim=0

        // Blocking read from FIFO interface
        decoder_in = inputData.read();

        // --------------------------------------------
        // Branch Metric Unit (BMU)
        // Format input data and compute branch metrics
        // --------------------------------------------
        if (SoftData) {

          // Soft data, decoded using Euclidean metric.  Soft decision data offers improved BER
          // performance over hard-coded data.

          const int ADDER_COUNT = GetBmuCostsMemEntries::entries;

          ap_uint<InputDataWidth> inv_input[OutputRate];
          ap_uint<InputDataWidth> clean_input[OutputRate];
          ap_uint<InputDataWidth+1+OutputRate-3> add_input[ADDER_COUNT][OutputRate];
          ap_uint<InputDataWidth+1+OutputRate-2> add_output[ADDER_COUNT][OutputRate];

          // Ensures II=1 can be met for higher values of OutputRate by forcing a register
          #pragma HLS ARRAY_PARTITION variable=add_input complete dim=0

          soft_data_input_loop : for (int input=0; input<OutputRate; input++) {
            int offset = input*InputDataWidth;
            din[input] = decoder_in.data(offset+InputDataWidth-1 , offset);

            if (HasEraseInput) {
              erase[input] = get_erase_bit(input, decoder_in);
            }

            // Data reformatting
            if (SoftDataFormat == SIGNED_MAGNITUDE) {
              //  MSB == 1 => do nothing, MSB == 0 => invert LSBs
              signed_magnitude_loop : for (int bit=0; bit<InputDataWidth-1; bit++) {
                din_formatted[input][bit] = (din[input][InputDataWidth-1] ^ din[input][bit]);
                din_formatted[input][bit] = ~din_formatted[input][bit];
              }
              din_formatted[input][InputDataWidth-1] = din[input][InputDataWidth-1];
            } else {
              // Do nothing
              din_formatted[input] = din[input];
            }

            // Erasure processing
            if (HasEraseInput && (erase[input] == 1)) {
              clean_input[input] = 0;
              inv_input[input] = 0;
            } else {
              clean_input[input] = din_formatted[input];
              inv_input_loop : for (int bit=0; bit<InputDataWidth; bit++) {
                inv_input[input][bit] = ~din_formatted[input][bit];
              }
            }
          }

          soft_data_add_input_outer_loop : for (int add_type=0; add_type<ADDER_COUNT; add_type++) {
            soft_data_add_input_inner_loop : for (int bit=0; bit<OutputRate; bit++) {
              int condition = (add_type >> bit) % 2;
              if (condition != 0) {
                add_input[add_type][bit] = inv_input[bit];
              } else {
                add_input[add_type][bit] = clean_input[bit];
              }
            }
          }

          soft_data_add_loop : for (int add_type=0; add_type<(1<<2); add_type++) {
            add_output[add_type][1] = add_input[add_type][0] + add_input[add_type][1];
          }

          if (OutputRate >= 3) { // build adder tree structure since more than two inputs
            soft_data_bmu_add_outer_loop : for (int i=3; i<=OutputRate; i++) {
              soft_data_bmu_add_inner_loop : for (int add_type=0; add_type<(1<<i); add_type++) {
                const int prev_rate = i-1;
                const int pr_rp = 1 << prev_rate;
                add_output[add_type][prev_rate] = add_output[add_type-(add_type/pr_rp)*pr_rp][prev_rate-1] + add_input[add_type][prev_rate];
              }
            }
          }

          soft_data_bmu_output_loop : for (int add_type=0; add_type<ADDER_COUNT; add_type++) {
            bmu_costs[add_type] = add_output[add_type][OutputRate-1];
          }

        } else { // not SoftData

          // Hard-coded data.  Decode using Hamming method.

          ap_uint<OutputRate> hard_input;
          hard_data_assign_loop : for (int input=0; input<OutputRate; input++) {
            hard_input[input] = decoder_in.data[input];
          }

          // Hamming distance
          // XOR input with all combinations of bits to find the distance
          hard_data_bmu_loop : for (int i=0; i<GetBmuCostsMemEntries::entries; i++) {
            bmu_costs[i] = count_ones<bmu_output_width::width>(hard_input ^ ap_uint<OutputRate>(i));
          }
        }


        // Connect ACS units
        acs_feedback_loop : for (int state=0; state< number_of_states::states; state++) {
          input_costs[state] = path_metrics[state];
          norm_check[state] = path_metrics[state][acs_width::width-1];
        }

        // Determine if normalization of the branch metrics is necessary
        // Normalization is necessary when the ACS metrics exceed a threshold, in order to avoid internal overflow
        ap_uint< number_of_states::states + 1 > norm_check_concat = (~norm_reg,norm_check); // Fold single-cycle behavior into comparison
        if (ConstraintLength > 8) {
          // To meet HLS timing estimates at 4ns on a 7 Series -1 speedgrade device, it is necessary to distribute the comparator over a number of logic levels
          const int TOTAL_BITS = (number_of_states::states + 1);
          const int CHUNK1_BITS = TOTAL_BITS / 3;
          const int CHUNK2_BITS = CHUNK1_BITS;
          const int CHUNK3_BITS = TOTAL_BITS - (CHUNK1_BITS + CHUNK2_BITS);
          ap_uint<CHUNK1_BITS> norm_chunk1 = norm_check_concat(CHUNK1_BITS-1,0);
          ap_uint<CHUNK2_BITS> norm_chunk2 = norm_check_concat(CHUNK1_BITS+CHUNK2_BITS-1,CHUNK1_BITS);
          ap_uint<CHUNK3_BITS> norm_chunk3 = norm_check_concat(TOTAL_BITS-1,CHUNK1_BITS+CHUNK2_BITS);
          ap_uint<CHUNK1_BITS> and_chunks = norm_chunk1 & norm_chunk2;
          norm = and_chunks.and_reduce() & norm_chunk3.and_reduce();
        } else {
          norm = norm_check_concat.and_reduce();
        }

        norm_reg = norm;
        norm_sr[1] = norm_sr[0]; // Delay of normalization pulse to align with expected data
        norm_sr[0] = norm_reg;
        normalize = norm_sr[1];

        // --------------------------------------------
        // Add-compare-select (ACS) stage
        // Optimized to map efficiently to carry chain logic
        // --------------------------------------------
        acs_loop : for (int state=0; state< number_of_states::states; state++) {
          const int ACS_WIDTH = acs_width::width;
          ap_uint<ACS_WIDTH+1> cost[BRANCHES];

          // Add
          acs_add_loop : for (int branch=0; branch<BRANCHES; branch++) {
            ap_uint<ACS_WIDTH> bmu_in = 0;
            bmu_in = bmu_costs[bmu_costs_index[state][branch]];
            bmu_in[ACS_WIDTH-1] = normalize;
            cost[branch] = bmu_in + input_costs[input_costs_index[state][branch]];

            if (~normalize[0] == 0) {
              cost[branch][ACS_WIDTH] = 0;
            }
          }

          // Compare
          ap_uint<1> comp_out_lut = (cost[0][ACS_WIDTH] ^ cost[1][ACS_WIDTH]);
          comp_out_lut[0] = ~comp_out_lut[0];

          ap_uint<ACS_WIDTH+2> sub = (cost[0]) - (cost[1]);
          ap_uint<1> comp_out = ~sub[ACS_WIDTH+1];
          path_from_acs[state] = comp_out;

          ap_uint<1> ovfl = cost[0][ACS_WIDTH] & cost[1][ACS_WIDTH];
          ap_uint<2> sw = (sub[ACS_WIDTH+1],ovfl);

          // Select
          switch (sw) {
          case 2:
            path_metrics[state] = cost[0];
            break;
          case 0:
            path_metrics[state] = cost[1];
            break;
          default:
            path_metrics_saturate_loop : for (int bit=0; bit<ACS_WIDTH; bit++) {
              path_metrics[state][bit] = 1;
            }
          }

        }


        // --------------------------------------------
        // Traceback
        // --------------------------------------------

        // Enable writing to output stream when data becomes valid
        if (output_valid_count == DATA_VALID_LATENCY) {
          output_valid_count_incr = 0;
        } else {
          output_valid_count_incr = 1;
        }
        output_valid_count = output_valid_count + output_valid_count_incr;
        output_valid = !output_valid_count_incr;

        // Terminal count for master counter
        if (base_count == TracebackLength-1) {
          base_count_tc = 1;
        } else {
          base_count_tc = 0;
        }

        // Traceback, decode and reordering logic based on k-pointer even algorithm, k=2
        // The traceback process begins at the zero state.
        // Two memories are used, with lifo_memory holding decoded data as well as
        // performing LIFO reordering via addressing
        decode_write = (decode_bit,path_from_acs); // Dummy write of decode_bit to make both memories consistent dimensions

        decode_read = traceback_memory[write_and_output_addr];
        traceback_memory[reg_write_and_output_addr] = reg_decode_write;

        decode = decode_read(number_of_states::states-1,0);

        // Rader's traceback decision addressing
        decode_bit = decode[decode_state];
        decode_state = (decode_bit,decode_state(state_bits::bits-1,1));

        traceback_write = (decode_bit,path_from_acs);

        // Use cached value when addresses match to remove a dependency and allow II=1
        if (traceback_addr == reg_write_and_output_addr) {
          traceback_read = reg_traceback_write;
        } else {
          traceback_read = lifo_memory[traceback_addr];
        }

        reg_traceback_write = (decode_bit,path_from_acs);
        lifo_memory[write_and_output_addr] = reg_traceback_write;

        reg_write_and_output_addr = write_and_output_addr;
        reg_decode_write = decode_write;

        traceback = traceback_read(number_of_states::states-1,0);
        lifo_out = traceback_read(number_of_states::states,number_of_states::states);

        traceback_bit = traceback[traceback_state];
        traceback_state = (traceback_bit,traceback_state(state_bits::bits-1,1));

        // Copy the current state from traceback to the decode state when traceback is
        // finished to provide the starting point for decoding
        if (base_count == TracebackLength-1) {
          decode_state = traceback_state;
        }

        // Set up offset for write/output address generator based on current block
        switch (block_count(1,0)) {
        case 0:
          offset_wr = 3*TracebackLength-1;
          break;
        case 1:
          offset_wr = 0;
          break;
        case 2:
          offset_wr = 1*TracebackLength-1;
          break;
        default:
          offset_wr = 2*TracebackLength-1;
        }

        // Implement the address counters as adders with multiplexed inputs for best LUT usage
        if (base_count_tc == 1 && block_count >= WRITE_BLOCK_COUNT_THRESH){
          write_fbk = 0;
          write_incr = offset_wr;
        } else {
          write_fbk = write_and_output_addr;
          write_incr = (block_count <= WRITE_BLOCK_COUNT_THRESH ? 1 : ~(0));
        }
        write_and_output_addr = write_fbk + write_incr;

        // Set up offset for traceback address generator based on current block
        switch (block_count) {
        case 0:
          offset_traceback = TracebackLength-1;
          break;
        case 1:
          offset_traceback = 2*TracebackLength-1;
          break;
        case 2:
          offset_traceback = 3*TracebackLength-1;
          break;
        default:
          offset_traceback = 0;
        }

        // Note: This relies on initialization in the constructor to achieve correct initial offset
        if (base_count_tc == 1 && block_count < TRACEBACK_BLOCK_COUNT_THRESH) {
          traceback_fbk = 0;
          traceback_incr = offset_traceback;
        } else {
          traceback_fbk = traceback_addr;
          traceback_incr = (block_count == 0 || block_count >= TRACEBACK_BLOCK_COUNT_THRESH ? 1 : ~(0));
        }
        traceback_addr = traceback_fbk + traceback_incr;

        // Traceback block counter
        if (base_count_tc == 1) {
          if (block_count == TOTAL_BLOCKS-1) {
            block_count = 0;
          } else {
            block_count++;
          }
        }

        // Master counter
        if (base_count == TracebackLength-1) {
          base_count = 0;
        } else {
          base_count++;
        }

        if (output_valid){
          outputData << lifo_out;
        }

      };

    }; // end class viterbi_decoder

} // end namespace hls

#endif // HLS_VITERBI_DECODER_H


