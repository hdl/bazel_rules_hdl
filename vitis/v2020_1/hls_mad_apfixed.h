// 67d7842dbbe25473c3c32b93c0da8047785f30d78e8a024de1b57352245f9689
#ifndef _X_HLS_GENERIC_MAD_H_
#define _X_HLS_GENERIC_MAD_H_
#include "ap_fixed.h"
namespace hls_mad {
    //mad for ap_fixed
    template <int W_, int I_>
    ap_fixed<W_,I_> generic_mad(ap_fixed<W_,I_> x, ap_fixed<W_,I_> y, ap_fixed<W_,I_> z){
        const unsigned int F_ = W_ - I_;
        ap_fixed<2*W_, 2*I_> mul = x * y;
        //rounding
        ap_fixed<2, -F_> delta = 0;
        delta[0] = 1;
        delta[1] = mul[2*W_-1];
        //add delta or subtract delta
        mul += delta;
        //if overflow
        ap_fixed<W_+1, I_+1> mul_s = mul;
        ap_fixed<W_+1, I_+1> sum = mul_s + z;
        ap_fixed<W_,I_> r = 0;
        //overflow
        if(sum[W_-1]!=sum[W_]) {
           for(int i = 0; i < W_-1; ++i) {
           #pragma HLS unroll
               r[i] = !sum[W_];
           }
           r[W_-1] = sum[W_];
        } else {
           r = sum;
        }
        return r;
    }
    //mad for ap_ufixed
    template <int W_, int I_>
    ap_ufixed<W_,I_> generic_mad(ap_ufixed<W_,I_> x, ap_ufixed<W_,I_> y, ap_ufixed<W_,I_> z){
        ap_fixed<W_+1, I_+1> xi = x;
        ap_fixed<W_+1, I_+1> yi = y;
        ap_fixed<W_+1, I_+1> zi = z;
        return generic_mad(xi, yi, zi);
    }
    //mad for ap_int
    template <int I_>
    ap_int<I_> generic_mad(ap_int<I_> x, ap_int<I_> y, ap_int<I_> z){
        ap_fixed<I_, I_> xi = x;
        ap_fixed<I_, I_> yi = y;
        ap_fixed<I_, I_> zi = z;
        return generic_mad(xi, yi, zi);
    }
    //mad for ap_uint
    template <int I_>
    ap_uint<I_> generic_mad(ap_uint<I_> x, ap_uint<I_> y, ap_uint<I_> z){
        ap_fixed<I_+1,I_+1> xi = x;
        ap_fixed<I_+1,I_+1> yi = y;
        ap_fixed<I_+1,I_+1> zi = z;
        return generic_mad(xi,yi,zi);
    }
}

#endif


