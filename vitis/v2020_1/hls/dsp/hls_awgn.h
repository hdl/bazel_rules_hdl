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

#ifndef HLS_AWGN_H
#define HLS_AWGN_H

#include "ap_fixed.h"
#include "ap_int.h"
#include <hls_stream.h>

namespace hls {
#if (defined(OutputWidth))
#error One or more of the template parameters used by this function is already defined and will cause a conflict
#endif

  // ===================================================================================================================
  // AWGN: Class definition
  // o Template parameters:
  //  - OutputWidth  : Selects the number of bits in the output.
  template<
    int OutputWidth>
    class awgn {

  public:

    // AWGN SNR input type definition
    typedef ap_ufixed<8,4, AP_RND, AP_SAT> t_input_scale;

    // The following constants are used to define the width of the LFSR seed
    static const int LFSR_SECTION_WIDTH = 32;
    static const int NUM_NOISE_GENS = 4;
    static const int LFSR_WIDTH = LFSR_SECTION_WIDTH*NUM_NOISE_GENS;

    awgn(ap_uint<LFSR_WIDTH> seed) {
      check_params(seed, OutputWidth);
      // Initialize LFSR state
      lfsr128 = seed;
      // Ensure state variables are reset
      #pragma HLS reset variable=lfsr128
    } //end constructor

    ~awgn() {
    } //end destructor


    // ===================================================================================================================
    // AWGN: Entry point function.
    // o Arguments:
    //  - snr        : signal to noise ratio desired.
    //  - outputData : Additive Gaussian white noise output data
    void operator()(const t_input_scale &snr,
                    ap_int<OutputWidth> &outputData) {

      Function_awgn_operator:;

      //The BRAM contents have been calculated using Excel which has the probit function,
      //then exported to csv so as to paste into this file.

      const ap_uint<BRAM_OUT_WIDTH> coarseContents[] = {
        131070,125628,122854,121035,119668,118569,117649,116856,116158,115536,114973,114459,113987,113549,113141,112760,112401,112062,111741,111437,111147,110870,110605,110351,110107,109873,109647,109429,109218,109015,108817,108626,
        108441,108261,108086,107915,107750,107588,107431,107277,107127,106980,106837,106697,106560,106426,106295,106166,106040,105916,105795,105675,105559,105444,105331,105220,105111,105004,104898,104795,104692,104592,104493,104395,
        104252,104065,103884,103707,103536,103368,103205,103045,102890,102738,102589,102444,102302,102163,102026,101893,101762,101633,101507,101384,101262,101143,101026,100911,100798,100686,100577,100469,100363,100259,100156,100054,
        99906,99712,99523,99340,99161,98987,98817,98651,98490,98331,98177,98026,97878,97733,97591,97452,97316,97182,97051,96922,96796,96672,96550,96430,96312,96196,96082,95970,95859,95750,95643,95538,
        95383,95180,94984,94793,94606,94425,94248,94075,93906,93741,93580,93422,93268,93117,92969,92823,92681,92542,92405,92270,92138,92008,91881,91756,91632,91511,91392,91275,91159,91045,90933,90823,
        90661,90449,90244,90043,89848,89658,89473,89292,89115,88943,88774,88609,88447,88288,88133,87981,87832,87686,87542,87401,87263,87126,86993,86861,86732,86605,86480,86357,86235,86116,85998,85882,
        85712,85490,85274,85063,84859,84659,84464,84274,84088,83906,83728,83555,83384,83218,83054,82894,82737,82583,82432,82283,82137,81994,81853,81714,81578,81444,81312,81182,81054,80928,80804,80682,
        80502,80267,80039,79817,79601,79389,79183,78982,78786,78594,78406,78222,78042,77865,77692,77523,77356,77193,77033,76875,76721,76569,76419,76272,76128,75985,75845,75708,75572,75438,75306,75177,
        74985,74736,74494,74258,74028,73803,73584,73370,73161,72957,72756,72561,72369,72181,71996,71815,71638,71464,71293,71125,70960,70798,70638,70481,70327,70175,70025,69878,69732,69589,69448,69310,
        69105,68839,68579,68326,68080,67839,67604,67374,67150,66930,66715,66505,66299,66097,65898,65704,65513,65326,65142,64961,64783,64608,64436,64267,64100,63937,63775,63616,63459,63305,63153,63003,
        62782,62494,62213,61939,61672,61412,61157,60908,60665,60426,60193,59965,59740,59521,59305,59094,58886,58682,58482,58284,58091,57900,57712,57528,57346,57167,56991,56817,56646,56477,56310,56146,
        55904,55589,55281,54981,54688,54401,54122,53848,53580,53318,53061,52809,52562,52319,52081,51848,51618,51392,51171,50952,50738,50526,50318,50114,49912,49713,49517,49324,49133,48945,48760,48577,
        48307,47955,47612,47276,46948,46628,46314,46007,45706,45412,45123,44839,44561,44287,44019,43755,43495,43240,42989,42741,42498,42258,42022,41789,41560,41333,41110,40890,40672,40458,40246,40036,
        39728,39324,38930,38544,38167,37797,37435,37080,36732,36390,36055,35725,35401,35082,34769,34460,34156,33857,33562,33272,32985,32703,32424,32149,31878,31610,31345,31083,30825,30569,30317,30067,
        29698,29215,28741,28277,27821,27374,26935,26503,26079,25661,25250,24845,24446,24053,23665,23282,22904,22531,22163,21799,21439,21083,20731,20383,20038,19697,19360,19025,18694,18365,18040,17717,
        17239,16609,15989,15378,14775,14180,13592,13011,12437,11868,11305,10748,10195,9647,9103,8563,8027,7494,6964,6437,5913,5391,4871,4353,3837,3322,2809,2297,1786,1275,765,255
      };
      const ap_uint<BRAM_OUT_WIDTH> gradientContents[] = {
        6999,3591,2146,1544,1210,997,849,740,657,590,536,492,454,422,394,370,348,329,312,297,283,271,259,249,239,230,222,214,207,200,194,188,
        183,178,173,168,164,159,156,152,148,145,142,139,136,133,130,127,125,123,120,118,116,114,112,110,108,106,105,103,101,100,98,97,
        189,184,179,174,170,165,161,157,154,150,147,144,141,138,135,132,130,127,125,123,120,118,116,114,112,110,109,107,105,104,102,101,
        197,191,186,181,176,172,168,164,160,156,153,149,146,143,140,138,135,132,130,128,125,123,121,119,117,115,113,111,110,108,106,105,
        205,199,194,189,184,179,175,171,167,163,159,156,153,150,147,144,141,138,136,133,131,129,126,124,122,120,118,116,115,113,111,110,
        214,208,203,197,192,188,183,179,175,171,167,163,160,157,154,151,148,145,142,140,137,135,133,130,128,126,124,122,120,119,117,115,
        225,219,213,208,202,197,193,188,184,180,176,172,168,165,162,159,156,153,150,147,145,142,140,137,135,133,131,129,127,125,123,121,
        238,231,225,219,214,208,204,199,194,190,186,182,178,175,171,168,165,162,159,156,153,151,148,146,143,141,139,137,135,133,131,129,
        252,246,239,233,227,222,217,212,207,202,198,194,190,186,183,179,176,173,169,167,164,161,158,156,153,151,148,146,144,142,140,138,
        270,263,256,250,244,238,232,227,222,217,213,208,204,200,196,193,189,186,182,179,176,173,171,168,165,163,160,158,156,153,151,149,
        292,284,277,270,264,258,252,246,241,236,231,226,222,218,214,210,206,202,199,195,192,189,186,183,180,178,175,173,170,168,165,163,
        320,312,304,297,290,283,277,271,265,260,254,249,245,240,236,232,228,224,220,216,213,210,206,203,200,197,195,192,189,187,184,182,
        357,348,339,332,324,317,310,304,298,292,286,281,276,271,266,262,257,253,249,245,242,238,235,231,228,225,222,219,216,213,211,208,
        408,399,390,381,373,366,358,352,345,339,333,327,321,316,311,306,301,297,293,288,284,281,277,273,270,266,263,260,257,254,251,248,
        489,478,469,460,451,443,435,428,421,414,408,402,396,391,385,380,375,371,366,362,358,354,350,346,343,339,336,333,330,327,324,321,
        635,625,616,607,599,591,584,578,571,566,560,555,550,546,542,538,535,531,528,526,523,521,519,517,515,514,513,512,511,510,510,510
      };

      // Probit lookup values have been prescaled by 26029.6788 to maximize use of the BRAM.

      const ap_uint<BRAM_OUT_WIDTH> scaleLookup[] = {
        116675,115838,115007,114183,113364,112551,111744,110943,110148,109358,108574,107796,107023,106255,105494,104737,
        103986,103241,102501,101766,101036,100312,99592,98878,98169,97466,96767,96073,95384,94700,94021,93347,
        92678,92013,91354,90699,90048,89403,88762,88125,87494,86866,86243,85625,85011,84402,83797,83196,
        82599,82007,81419,80835,80256,79680,79109,78542,77979,77420,76865,76313,75766,75223,74684,74148,
        73617,73089,72565,72045,71528,71015,70506,70000,69499,69000,68506,68014,67527,67043,66562,66085,
        65611,65140,64673,64210,63749,63292,62839,62388,61941,61497,61056,60618,60183,59752,59323,58898,
        58476,58057,57640,57227,56817,56409,56005,55603,55205,54809,54416,54026,53638,53254,52872,52493,
        52117,51743,51372,51004,50638,50275,49914,49557,49201,48848,48498,48151,47805,47463,47122,46784,
        46449,46116,45785,45457,45131,44808,44486,44167,43851,43536,43224,42914,42607,42301,41998,41697,
        41398,41101,40806,40514,40223,39935,39648,39364,39082,38802,38524,38247,37973,37701,37431,37162,
        36896,36631,36369,36108,35849,35592,35337,35083,34832,34582,34334,34088,33844,33601,33360,33121,
        32883,32648,32414,32181,31950,31721,31494,31268,31044,30821,30600,30381,30163,29947,29732,29519,
        29307,29097,28889,28681,28476,28272,28069,27868,27668,27470,27273,27077,26883,26690,26499,26309,
        26120,25933,25747,25562,25379,25197,25016,24837,24659,24482,24307,24132,23959,23788,23617,23448,
        23280,23113,22947,22782,22619,22457,22296,22136,21977,21820,21663,21508,21354,21201,21049,20898,
        20748,20599,20452,20305,20159,20015,19871,19729,19587,19447,19308,19169,19032,18895,18760,18625
      };

      const ap_int<OutputWidth> C_MAX_NOISE = ((ap_int<OutputWidth>)1 << (OutputWidth-1)) -1;
      const ap_int<OutputWidth> C_MIN_NOISE = -C_MAX_NOISE;
      const int C_ROUND_POINT = SCALED_NOISE_WIDTH-ROUNDED_NOISE_GUARD - OutputWidth;

      ap_uint<BRAM_OUT_WIDTH>                 scale;
      ap_uint<SCALE_ADDR_WIDTH>               scaleAddr;
      ap_uint<BRAM_ADDR_WIDTH>                bramChapter[NUM_NOISE_GENS];
      ap_uint<BRAM_PAGE_WIDTH>                bramPage[NUM_NOISE_GENS];
      ap_uint<BRAM_ADDR_WIDTH>                bramAddr[NUM_NOISE_GENS];
      ap_uint<1>                              signAddr[NUM_NOISE_GENS];
      ap_uint<COMPAND_IN>                     norm[NUM_NOISE_GENS][5];
      ap_uint<BRAM_OUT_WIDTH>                 coarse[NUM_NOISE_GENS];
      ap_uint<BRAM_OUT_WIDTH>                 gradient[NUM_NOISE_GENS];
      ap_int<OFFSET_WIDTH>                    offset[NUM_NOISE_GENS];
      ap_int<NOISE_WIDTH>                     adjust[NUM_NOISE_GENS];
      ap_int<NOISE_WIDTH>                     shiftedCoarse[NUM_NOISE_GENS];
      ap_int<NOISE_WIDTH>                     noiseGen[NUM_NOISE_GENS];
      ap_int<CL_NOISE_WIDTH>                  centralLimitNoise;
      ap_int<SCALED_NOISE_WIDTH>              scaledNoise;
      ap_int<OutputWidth+ROUNDED_NOISE_GUARD> roundedNoise;
      ap_int<OutputWidth>                     saturatedNoise;
      ap_uint<LFSR_SECTION_WIDTH>             lfsrSplice[NUM_NOISE_GENS];//splices of lfsr128

      // Default is to have multiple parallel noise generators, hence unroll this loop.
      noise_gen_loop: for (int i = 0; i < NUM_NOISE_GENS; i++) {
        lfsrSplice[i] = (lfsr128 >> (i*LFSR_SECTION_WIDTH)) & (((ap_uint<LFSR_SECTION_WIDTH+1>)1 << LFSR_SECTION_WIDTH)-1);
        signAddr[i] = (lfsrSplice[i]>>(LFSR_SECTION_WIDTH-1)) & 1; //sign is top bit of LFSR
        //Normalizer
        //LFSR_SECTION_WIDTH bits describe the region 0 to 1 as a uniform random variable.
        //This uniform range is converted to Gaussian using the probit function.
        //Since the probit function is steep close to 0 the use of the BRAM is concentrated
        //to those values by companding.
        //The 32 bit LFSR is split into the following fields
        //sign    (bit 31)
        //Chapter (bits 29 downto 15) (15 bits). This is normalized to a 4 bit field.
        //Page    (bits 14 downto 10)
        //Offset  (bits 9 downto 0)
        //The top splice bit determines the region 0 to 0.5 or 0.5 to 1 because
        //Probit is negative-Symmetric about the point (0.5, 0) so the BRAM is used only
        //for range 0 to 0.5
        //Chapter normalized in order to count the number of leading zeros.
        //This determines the 'chapter' of RAM to use. Hence BRAM use is log2 companded.
        //Each chapter is composed of 32 pages. These addresses within a chapter.
        //The remaining bits are used to linearly interpolate between BRAM-read values.
        //This linear interpolation comes from a coarse value lookup, based on chapter&page.
        //and a gradient value also looked up using the chapter&page address.
        //The coarse part has to be shifted up by the width of the offset field before adding the correction (linear interp) factor.

        //Get the 15 bit field for normalization and conversion to chapter field.
        norm[i][0] = (lfsrSplice[i]>>(BRAM_PAGE_WIDTH+OFFSET_WIDTH)) & 0x7FFF;
        //norm[i][0] is the field to be normalised. The number of bits it is shifted by gives
        //the ram section, the bits after the leading 1 become the interpolation bits.
        bramChapter[i] = 0;
        normalizer_stage_loop: for (int normStage = 0; normStage < NORM_STAGES; normStage++ ) {
          if ((norm[i][normStage] >> ((1<<NORM_STAGES) - (1<<(NORM_STAGES-1-normStage)) - 1)) == 0) {
            norm[i][normStage+1] = norm[i][normStage]<<((ap_uint<NORM_STAGES>)1<<(NORM_STAGES - 1 - normStage));
          } else {
            bramChapter[i] += (ap_uint<BRAM_ADDR_WIDTH>)1 << (BRAM_ADDR_WIDTH - 1 - normStage);
            norm[i][normStage+1] = norm[i][normStage];
          }
        }
        // Top NORM_STAGES bits of bram should now be set.
        // Use next 6 bits of lfsr state
        bramPage[i] = (ap_uint<BRAM_ADDR_WIDTH>)((lfsrSplice[i] >> OFFSET_WIDTH) & 0x1f);
        bramAddr[i] = bramChapter[i] + bramPage[i];
        offset[i] = (ap_int<OFFSET_WIDTH>)(lfsrSplice[i] & ((1 << OFFSET_WIDTH)-1)); //offset takes the least significant bits of the LFSR.
        coarse[i] = coarseContents[bramAddr[i]];
        gradient[i] = gradientContents[bramAddr[i]];

        // The use of the sign bit is phrased to be sympathetic to DSP48 inference
        adjust[i] = gradient[i] * offset[i];
        shiftedCoarse[i] = (ap_int<NOISE_WIDTH>)coarse[i] << OFFSET_WIDTH;
        if (signAddr[i]==0) {
          noiseGen[i] = shiftedCoarse[i] + adjust[i];
        } else {
          noiseGen[i] = adjust[i] - shiftedCoarse[i];
        }
      }
      // Move the lfsr on one state.
      tickLfsr(lfsr128);

      // TIP: Enable the pragma below, or apply a directive, to map addition to DSP Slices
      //#pragma HLS RESOURCE variable=centralLimitNoise core=AddSub_DSP
      centralLimitNoise = ((ap_int<CL_NOISE_WIDTH>)noiseGen[0]+
                           (ap_int<CL_NOISE_WIDTH>)noiseGen[1]+
                           (ap_int<CL_NOISE_WIDTH>)noiseGen[2]+
                           (ap_int<CL_NOISE_WIDTH>)noiseGen[3]);//Adder tree variant

      scaleAddr = (int)(snr * 16);
      scale = scaleLookup[scaleAddr];
      scaledNoise = centralLimitNoise * scale;
      roundedNoise = (scaledNoise + ((ap_uint<C_ROUND_POINT>)1 << (C_ROUND_POINT-1))) >> C_ROUND_POINT;
      if(roundedNoise > C_MAX_NOISE) {
        saturatedNoise = C_MAX_NOISE;
      }
      else if (roundedNoise < C_MIN_NOISE) {
        saturatedNoise = C_MIN_NOISE;
      }
      else {
        saturatedNoise = roundedNoise;
      }
      outputData = saturatedNoise;

    } // operator()


  private:

    // Struct to define the LFSR configuration
    struct xor_triple {
      int width;
      int a;
      int b;
      int c;
    };

    // Shared constants
    static const int SCALE_ADDR_WIDTH = 8;
    static const int COMPAND_IN = 15;
    static const int BRAM_CHAPTER_WIDTH = 4;
    static const int BRAM_PAGE_WIDTH = 5;
    static const int OFFSET_WIDTH = 10;
    static const int LOG2NUMNOISEGENS = 2;  // If changing, change the previous one too
    static const int NORM_STAGES = 4;
    static const int BRAM_ADDR_WIDTH = 9;
    static const int BRAM_OUT_WIDTH = 17;
    static const int SCALE_WIDTH = 17;
    static const int MIN_OUTPUT_WIDTH = 8;
    static const int MAX_OUTPUT_WIDTH = 32;
    static const int LFSR_FORM = 1;

    // Derived constants
    // Noise width is +2 to accommodate arithmetic bit growth
    static const int NOISE_WIDTH = (BRAM_OUT_WIDTH + OFFSET_WIDTH + 2);
    static const int CL_NOISE_WIDTH = (NOISE_WIDTH + LOG2NUMNOISEGENS );
    static const int SCALED_NOISE_WIDTH = (CL_NOISE_WIDTH + SCALE_WIDTH);
    // The maximum noise is ~10 std devs, but the maximum output value is 2root2 std_devs. Hence, so as not to overflow, the rounded noise must accommodate values up to ~5x the maximum noise output.
    static const int ROUNDED_NOISE_GUARD = 3;

    // State variables
    ap_uint<LFSR_WIDTH> lfsr128;

    void check_params(ap_uint<LFSR_WIDTH> pSeed, int pOutputWidth) {
      // Verify that template parameters are correct in simulation
      #ifndef __SYNTHESIS__
      if (pSeed == 0) {
        std::cout << "ERROR: " << __FILE__ << ": Seed to LFSR must not be zero" << std::endl;
        exit(1);
      }
      if (pOutputWidth < MIN_OUTPUT_WIDTH || pOutputWidth > MAX_OUTPUT_WIDTH) {
        std::cout << "ERROR: " << __FILE__ << ": OutputWidth must be in range " << MIN_OUTPUT_WIDTH << " to " << MAX_OUTPUT_WIDTH << std::endl;
        exit(1);
      }
      #endif
    } // check_params


    // xorShift moves the LFSR on by one state. The LFSR equation depends on y and form.
    void xorShift(ap_uint<(LFSR_WIDTH >> 1) > &lfsrVal,
                  const struct xor_triple &y,
                  int form) {
      switch (form) {
      case 0:
        lfsrVal = ((lfsrVal << y.a) ^ lfsrVal);
        lfsrVal = ((lfsrVal >> y.b) ^ lfsrVal);
        lfsrVal = ((lfsrVal << y.c) ^ lfsrVal);
        break;
      case 1:
        lfsrVal = ((lfsrVal << y.c) ^ lfsrVal);
        lfsrVal = ((lfsrVal >> y.b) ^ lfsrVal);
        lfsrVal = ((lfsrVal << y.a) ^ lfsrVal);
        break;
      case 2:
        lfsrVal = ((lfsrVal >> y.a) ^ lfsrVal);
        lfsrVal = ((lfsrVal << y.b) ^ lfsrVal);
        lfsrVal = ((lfsrVal >> y.c) ^ lfsrVal);
        break;
      case 3:
        lfsrVal = ((lfsrVal >> y.c) ^ lfsrVal);
        lfsrVal = ((lfsrVal << y.b) ^ lfsrVal);
        lfsrVal = ((lfsrVal >> y.a) ^ lfsrVal);
        break;
      case 4:
        lfsrVal = ((lfsrVal << y.a) ^ lfsrVal);
        lfsrVal = ((lfsrVal << y.c) ^ lfsrVal);
        lfsrVal = ((lfsrVal >> y.b) ^ lfsrVal);
        break;
      case 5:
        lfsrVal = ((lfsrVal << y.c) ^ lfsrVal);
        lfsrVal = ((lfsrVal << y.a) ^ lfsrVal);
        lfsrVal = ((lfsrVal >> y.b) ^ lfsrVal);
        break;
      case 6:
        lfsrVal = ((lfsrVal >> y.a) ^ lfsrVal);
        lfsrVal = ((lfsrVal >> y.c) ^ lfsrVal);
        lfsrVal = ((lfsrVal << y.b) ^ lfsrVal);
        break;
      case 7:
        lfsrVal = ((lfsrVal >> y.c) ^ lfsrVal);
        lfsrVal = ((lfsrVal >> y.a) ^ lfsrVal);
        lfsrVal = ((lfsrVal << y.b) ^ lfsrVal);
        break;
      default:
        #ifndef __SYNTHESIS__
        std::cout << "ERROR: " << __FILE__ << ": Illegal form passed to xorShift\n" << std::endl;
        exit(1);
        #endif
        break;
      }
    } // xorShift

    void tickLfsr(ap_uint<LFSR_WIDTH> &lfsrState) {

      Function_awgn_tickLfsr:;

      //Ideally, a single LFSR would be used for this application, as that would yield
      //the longest sequence. However, very long LFSRs give higher fan-in. Hence a compromise
      //of using 2 64-bit LFSRs is used. 2^64 at 1GHz gives a repeat time of >500 years.
      //See xorshift on Wikipedia.
      const struct xor_triple myLfsrPoly1 = {64,1,35,34};
      const struct xor_triple myLfsrPoly2 = {64,7,13,58};

      ap_uint<(LFSR_WIDTH >>1) > lfsr1,lfsr2;

      lfsr1 = lfsrState.range(LFSR_WIDTH-1,LFSR_WIDTH/2);
      lfsr2 = lfsrState.range(LFSR_WIDTH/2-1,0);

      xorShift(lfsr1, myLfsrPoly1, LFSR_FORM);
      xorShift(lfsr2, myLfsrPoly2, LFSR_FORM);
      lfsrState = (lfsr1,lfsr2);

    } // tickLfsr

  }; //end class awgn

} //end namespace hls

#endif // HLS_AWGN_H






