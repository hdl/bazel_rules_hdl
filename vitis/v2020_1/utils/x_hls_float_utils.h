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
 *     (c) Copyright 2012 Xilinx Inc.
 *     All rights reserved.
 *
 *****************************************************************************/

#ifndef X_HLS_FLOAT_UTILS_H
#define X_HLS_FLOAT_UTILS_H
#include <assert.h>

static const ap_uint<100> ref_cordic("9b74eda8435e5a67f5f9092c6",16);

//Q115.397
static const ap_uint<512> ref_4oPi_512("000000000000000000000000000028BE60DB9391054A7F09D5F47D4D377036D8A5664F10E4107F9458EAF7AEF1586DC91B8E909374B801924BBA827464873FBF",16);

/*
* Double-precision calculations
* hi: 400-1-2+( 53-e1+1)    = 451-e1    = 399 (e1=52)
* lo: 400-1-2+(-53-e1-1-p1) = 343-e1-p1 = 281 (e1=52,p1=10)
*
* left-justified alignment
* e1	hi	lo	i	<<
* ----	---	---	---	-------
* 52	399	281	1	0
* 53	398	281	1	1
* 61			1	9
* 179			1	127
* 180			2	0
*
*-------------------------------------------------------------------
* Need to select 119-bits from ~1024 bits.
* 256 bits allows 128-bit selection shifted 128 bits.
* 128-bits is bigger than 119 which we need in the double-precision
* range reduction payne-hanek.
* 128-bits * 10 = 1280 which is > 1024 bits
*-------------------------------------------------------------------
*/
static const ap_uint<256> ref_4oPi_table_256[10] = {
    "0x0000000000000000000000000000000028be60db9391054a7f09d5f47d4d3770",
    "0x28be60db9391054a7f09d5f47d4d377036d8a5664f10e4107f9458eaf7aef158",
    "0x36d8a5664f10e4107f9458eaf7aef1586dc91b8e909374b801924bba82746487",
    "0x6dc91b8e909374b801924bba827464873f877ac72c4a69cfba208d7d4baed121",
    "0x3f877ac72c4a69cfba208d7d4baed1213a671c09ad17df904e64758e60d4ce7d",
    "0x3a671c09ad17df904e64758e60d4ce7d272117e2ef7e4a0ec7fe25fff7816603",
    "0x272117e2ef7e4a0ec7fe25fff7816603fbcbc462d6829b47db4d9fb3c9f2c26d",
    "0xfbcbc462d6829b47db4d9fb3c9f2c26dd3d18fd9a797fa8b5d49eeb1faf97c5e",
    "0xd3d18fd9a797fa8b5d49eeb1faf97c5ecf41ce7de294a4ba9afed7ec47e35742",
    "0xcf41ce7de294a4ba9afed7ec47e357421580cc11bf1edaeafc33ef0826bd0d87",
};

static const ap_uint<100> ref_4oPi_table_100[13] = {
    "0x000000000000000000000028B", // -4
    "0x00000000000000000028BE60D", // -3
    "0x0000000000000028BE60DB939", // -2
    "0x000000000028BE60DB9391054", // -1
    "0x00000028BE60DB9391054A7F0", // 0
    "0x0028BE60DB9391054A7F09D5F", // 1
    "0xBE60DB9391054A7F09D5F47D4", // 2
    "0xDB9391054A7F09D5F47D4D377", // 3
    "0x91054A7F09D5F47D4D377036D", // 4
    "0x4A7F09D5F47D4D377036D8A56", // 5
    "0x09D5F47D4D377036D8A5664F1", // 6
    "0xF47D4D377036D8A5664F10E41", // 7
    "0x4D377036D8A5664F10E417F94", // 8
};

static const ap_uint<80> ref_4oPi_table_80[9] = {
    "0x00000028BE60DB939105", // 0
    "0x0028BE60DB9391054A7F", // 1
    "0xBE60DB9391054A7F09D5", // 2
    "0xDB9391054A7F09D5F47D", // 3
    "0x91054A7F09D5F47D4D37", // 4
    "0x4A7F09D5F47D4D377036", // 5
    "0x09D5F47D4D377036D8A5", // 6
    "0xF47D4D377036D8A5664F", // 7
    "0x4D377036D8A5664F10E4", // 8
};


// Q2.398
static const ap_uint<400> ref_Pio4_400("3243F6A8885A308D313198A2E03707344A4093822299F31D0082EFA98EC4E6C89452821E638D01377BE5466CF34E90C6CC0A",16);

static const ap_uint<256> ref_Pio4_table[10] = {
    "0x000000000000000000000000000000003243f6a8885a308d313198a2e0370734",
    "0x3243f6a8885a308d313198a2e03707344a4093822299f31d0082efa98ec4e6c8",
    "0x4a4093822299f31d0082efa98ec4e6c89452821e638d01377be5466cf34e90c6",
    "0x9452821e638d01377be5466cf34e90c6cc0ac29b7c97c50dd3f84d5b5b547091",
    "0xcc0ac29b7c97c50dd3f84d5b5b54709179216d5d98979fb1bd1310ba698dfb5a",
    "0x79216d5d98979fb1bd1310ba698dfb5ac2ffd72dbd01adfb7b8e1afed6a267e9",
    "0xc2ffd72dbd01adfb7b8e1afed6a267e96ba7c9045f12c7f9924a19947b3916cf",
    "0x6ba7c9045f12c7f9924a19947b3916cf70801f2e2858efc16636920d871574e6",
    "0x70801f2e2858efc16636920d871574e69a458fea3f4933d7e0d95748f728eb65",
    "0x9a458fea3f4933d7e0d95748f728eb658718bcd5882154aee7b54a41dc25a59b",
};


template <int W, int I>
void scaled_fixed2ieee(ap_fixed<W, I> in, half &result, int prescale)
{
    //#pragma HLS inline off
    fp_struct<half> out;
    out.sign[0] = in[in.wl()-1];

    // Note that when we chop off the sign bit, we don't loose any
    // bits to allow for -MAX to be converted correctly.
    ap_ufixed<W,I> ain = in;
    if(out.__signbit()) {
        ain = -in;
    }

    // Count the leading zeros and shift
    int shift = ain.countLeadingZeros();
    ap_ufixed<W, I> in_shift = ain << shift;

    //    assert(in_shift[W-1] == 1);
    ap_ufixed<W,1> result_mantissa; // Reinterpret the bits as a mantissa.

    int newexp = (int)fp_struct<half>::EXP_BIAS+in_shift.iwl()-1-prescale-shift;
#if !defined(__SYNTHESIS__) && defined(_HLSCLIB_DEBUG_)
    std::cout << "in_shift = " << in_shift << "\n";
    std::cout << "shift = " << shift << "\n";
    std::cout << "newexp = " << newexp << "\n";
#endif
    if(newexp < 0 || in == 0) {
        result_mantissa = 0;
        newexp = 0;
    } else {
        result_mantissa(W-1,0) = in_shift(W-1,0);
        assert(newexp<fp_struct<half>::EXP_INFNAN);
        assert(newexp>=0);
    }

    // Truncate the implicit one and zero extend, if necessary.
    out.set_mantissa(result_mantissa);
    out.exp = newexp;

    result = out.to_ieee();
}

template <int W, int I>
void scaled_fixed2ieee(ap_ufixed<W, I> in, half &result, int prescale)
{
    //#pragma HLS inline off
    fp_struct<half> out;
    out.sign[0] = 0;

    ap_ufixed<W,I> ain = in;

    // Count the leading zeros and shift
    int shift = ain.countLeadingZeros();
    ap_ufixed<W, I> in_shift = ain << shift;

    //    assert(in_shift[W-1] == 1);
    ap_ufixed<W,1> result_mantissa; // Reinterpret the bits as a mantissa.

    int newexp = (int)fp_struct<half>::EXP_BIAS+in_shift.iwl()-1-prescale-shift;
#if !defined(__SYNTHESIS__) && defined(_HLSCLIB_DEBUG_)
    std::cout << "in_shift = " << in_shift << "\n";
    std::cout << "shift = " << shift << "\n";
    std::cout << "newexp = " << newexp << "\n";
#endif
    if(newexp < 0 || in == 0) {
        result_mantissa = 0;
        newexp = 0;
    } else {
        result_mantissa(W-1,0) = in_shift(W-1,0);
        assert(newexp<fp_struct<half>::EXP_INFNAN);
        assert(newexp>=0);
    }

    // Truncate the implicit one and zero extend, if necessary.
    out.set_mantissa(result_mantissa);
    out.exp = newexp;
    result = out.to_ieee();
}

#define __hls_parts ((W+15)/16)
#define __hls_rem (W - (__hls_parts-1)*16)
template <int W, int I>
void scaled_fixed2ieee(ap_fixed<W, I> in, float &result, int prescale)
{
    //#pragma HLS inline off
    fp_struct<float> out;
    out.sign[0] = in[in.wl()-1];

    // Note that when we chop off the sign bit, we don't loose any
    // bits to allow for -MAX to be converted correctly.
    ap_ufixed<W,I> ain = in;

    if(out.__signbit()) {
        ain = -in;
    }

    //const int __hls_parts = (W+15)/16;
    //const int __hls_rem = W - (__hls_parts-1)*16;
    assert(__hls_rem > 0);
    assert(__hls_rem <= 16);

    // Chop into 16 bit segments. 
    ap_uint<32> out_bits[__hls_parts] = {};
    for(int i = 0; i < __hls_parts-1; i++) {
        out_bits[i](31, 16) = ain(ain.wl()-16*i-1,
                                  ain.wl()-16*i-16);
        out_bits[i][15] = 1;
    }
    out_bits[__hls_parts-1](32-1,32-__hls_rem) = ain(ain.wl()-16*(__hls_parts-1)-1,
                                         ain.wl()-16*(__hls_parts-1)-__hls_rem);
    out_bits[__hls_parts-1][32-__hls_rem-1] = 1;

    // Count the leading zeros in each segment.
    int c[__hls_parts];
    for(int i = 0; i < __hls_parts; i++) {
        c[i] = clz(out_bits[i].to_uint());
    }

    int shift = 0;
    ap_ufixed<W, I> in_shift = ain;

    for(int i = 0; i < __hls_parts; i++) {
        shift += c[i];
        in_shift = in_shift << c[i];
#if !defined(__SYNTHESIS__) && defined(_HLSCLIB_DEBUG_)
        std::cout << "c[" << i << "] = " << c[i] << " ";
        std::cout << "in_shift = " << in_shift << "\n";
#endif
        if(c[i] != 16) {
            break;
        }
    }

    //    assert(in_shift[W-1] == 1);
    ap_ufixed<W,1> result_mantissa; // Reinterpret the bits as a mantissa.

    int newexp = ((int)fp_struct<float>::EXP_BIAS+in_shift.iwl()-1-prescale-shift);
#if !defined(__SYNTHESIS__) && defined(_HLSCLIB_DEBUG_)
    std::cout << "in_shift = " << in_shift << "\n";
    std::cout << "shift = " << shift << "\n";
    std::cout << "newexp = " << newexp << "\n";
#endif
    if(newexp < 0 || in == 0) {
        result_mantissa = 0;
        newexp = 0;
    } else {
        result_mantissa(W-1,0) = in_shift(W-1,0);
        assert(newexp<fp_struct<float>::EXP_INFNAN);
        assert(newexp>=0);
    }

    // Truncate the implicit one and zero extend, if necessary.
    out.set_mantissa(result_mantissa);
    out.exp = newexp;
    result = out.to_ieee();
}


template <int W, int I>
void scaled_fixed2ieee(ap_ufixed<W, I> in, float &result, int prescale)
{
    //#pragma HLS inline off
	
    fp_struct<float> out;
    out.sign[0] = 0;
    ap_ufixed<W,I> ain = in;

    assert(__hls_rem > 0);
    assert(__hls_rem <= 16);

    // Chop into 16 bit segments. out_bits[0] includes the MSBs.
    ap_uint<32> out_bits[__hls_parts] = {};
    for(int i = 0; i < __hls_parts-1; i++) {
        out_bits[i](31, 16) = ain(ain.wl()-16*i-1,
                                  ain.wl()-16*i-16);
        out_bits[i][15] = 1;
    }
    out_bits[__hls_parts-1](32-1,32-__hls_rem) = ain(ain.wl()-16*(__hls_parts-1)-1,
                                         ain.wl()-16*(__hls_parts-1)-__hls_rem);
    out_bits[__hls_parts-1][32-__hls_rem-1] = 1;

    // Count the leading zeros in each segment.
    int c[__hls_parts];
    for(int i = 0; i < __hls_parts; i++) {
        c[i] = clz(out_bits[i].to_uint());
    }

    int shift = 0;
    ap_ufixed<W, I> in_shift = ain;

    for(int i = 0; i < __hls_parts; i++) {
        shift += c[i];
        in_shift = in_shift << c[i];
        if(c[i] != 16) {
            break;
        }
    }

    //    assert(in_shift[W-1] == 1);
    ap_ufixed<W,1> result_mantissa; // Reinterpret the bits as a mantissa.

    int newexp = (int)fp_struct<float>::EXP_BIAS+in_shift.iwl()-1-prescale-shift;
#if !defined(__SYNTHESIS__) && defined(_HLSCLIB_DEBUG_)
    std::cout << "in_shift = " << in_shift << "\n";
    std::cout << "shift = " << shift << "\n";
    std::cout << "newexp = " << newexp << "\n";
#endif
    if(newexp < 0 || in == 0) {
        result_mantissa = 0;
        newexp = 0;
    } else {
        result_mantissa(W-1,0) = in_shift(W-1,0);
        assert(newexp<fp_struct<float>::EXP_INFNAN);
        assert(newexp>=0);
    }

    // Truncate the implicit one and zero extend, if necessary.
    out.set_mantissa(result_mantissa);
    out.exp = newexp;
    result = out.to_ieee();
}

template <int W, int I>
void scaled_fixed2ieee(ap_fixed<W, I> in, double &result, int prescale)
{
    //#pragma HLS inline off
    fp_struct<double> out;
    out.sign[0] = in[in.wl()-1];

    // Note that when we chop off the sign bit, we don't loose any
    // bits to allow for -MAX to be converted correctly.
    ap_ufixed<W,I> ain = in;

    if(out.__signbit()) {
        ain = -in;
    }

    assert(__hls_rem > 0);
    assert(__hls_rem <= 16);

    // Chop into 16 bit segments. 
    ap_uint<32> out_bits[__hls_parts] = {};
    for(int i = 0; i < __hls_parts-1; i++) {
        out_bits[i](31, 16) = ain(ain.wl()-16*i-1,
                                  ain.wl()-16*i-16);
        out_bits[i][15] = 1;
    }
    out_bits[__hls_parts-1](32-1,32-__hls_rem) = ain(ain.wl()-16*(__hls_parts-1)-1,
                                         ain.wl()-16*(__hls_parts-1)-__hls_rem);
    out_bits[__hls_parts-1][32-__hls_rem-1] = 1;

    // Count the leading zeros in each segment.
    int c[__hls_parts];
    for(int i = 0; i < __hls_parts; i++) {
        c[i] = clz(out_bits[i].to_uint());
    }

    int shift = 0;
    ap_ufixed<W, I> in_shift = ain;

    for(int i = 0; i < __hls_parts; i++) {
        shift += c[i];
        in_shift = in_shift << c[i];
        if(c[i] != 16) {
            break;
        }
    }

    //    assert(in_shift[W-1] == 1);
    ap_ufixed<W,1> result_mantissa; // Reinterpret the bits as a mantissa.

    int newexp = (int)fp_struct<double>::EXP_BIAS+in_shift.iwl()-1-prescale-shift;
    if(newexp < 0 || in == 0) {
        result_mantissa = 0;
        newexp = 0;
    } else {
        result_mantissa(W-1,0) = in_shift(W-1,0);
        assert(newexp<fp_struct<double>::EXP_INFNAN);
        assert(newexp>=0);
    }

    // Truncate the implicit one and zero extend, if necessary.
    out.set_mantissa(result_mantissa);
    out.exp = newexp;
    result = out.to_ieee();
}

template <int W, int I>
void scaled_fixed2ieee(ap_ufixed<W, I> in, double &result, int prescale)
{
    //#pragma HLS inline off
    fp_struct<double> out;
    out.sign[0] = 0;
    ap_ufixed<W,I> ain = in;

    assert(__hls_rem > 0);
    assert(__hls_rem <= 16);

    // Chop into 16 bit segments.
    ap_uint<32> out_bits[__hls_parts] = {};
    for(int i = 0; i < __hls_parts-1; i++) {
        out_bits[i](31, 16) = ain(ain.wl()-16*i-1,
                                  ain.wl()-16*i-16);
        out_bits[i][15] = 1;
    }
    out_bits[__hls_parts-1](32-1,32-__hls_rem) = ain(ain.wl()-16*(__hls_parts-1)-1,
                                         ain.wl()-16*(__hls_parts-1)-__hls_rem);
    out_bits[__hls_parts-1][32-__hls_rem-1] = 1;

    // Count the leading zeros in each segment.
    int c[__hls_parts];
    for(int i = 0; i < __hls_parts; i++) {
        c[i] = clz(out_bits[i].to_uint());
    }

    int shift = 0;
    ap_fixed<W, I> in_shift = ain;

    for(int i = 0; i < __hls_parts; i++) {
        shift += c[i];
        in_shift = in_shift << c[i];
        if(c[i] != 16) {
            break;
        }
    }

    //    assert(in_shift[W-1] == 1);
    ap_ufixed<W,1> result_mantissa; // Reinterpret the bits as a mantissa.

    int newexp = (int)fp_struct<double>::EXP_BIAS+in_shift.iwl()-1-prescale-shift;
    if(newexp < 0 || in == 0) {
        result_mantissa = 0;
        newexp = 0;
    } else {
        result_mantissa(W-1,0) = in_shift(W-1,0);
        assert(newexp<fp_struct<double>::EXP_INFNAN);
        assert(newexp>=0);
    }

    // Truncate the implicit one and zero extend, if necessary.
    out.set_mantissa(result_mantissa);
    out.exp = newexp;

    result = out.to_ieee();
}
#undef __hls_parts
#undef __hls_rem

#endif



