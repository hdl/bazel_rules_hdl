// 67d7842dbbe25473c3c32b93c0da8047785f30d78e8a024de1b57352245f9689
#ifndef _X_HLS_GENERIC_FRACT_H_
#define _X_HLS_GENERIC_FRACT_H_

#include "utils/x_hls_defines.h"
#include "utils/x_hls_utils.h"
#include "utils/x_hls_traits.h"

namespace hls_fract {
//fract for ap_fixed
template <int W_, int I_>
ap_fixed<W_,I_> generic_fract(ap_fixed<W_,I_> x){
	if (W_==I_)return 0;
	ap_fixed<W_-I_+1,1> x1=x;
	ap_fixed<W_-I_+1,1> x2=x1+ap_int<2>(1);
	return x[W_-1]?x2:x1;
}
//fract for ap_ufixed
template <int W_, int I_>
ap_ufixed<W_,I_> generic_fract(ap_ufixed<W_,I_> x){
	ap_fixed<W_+1,I_+1> x1=x;
	return generic_fract(x1);
}
//fract for ap_int
template <int I_>
ap_int<I_> generic_fract(ap_int<I_> x){
	ap_fixed<I_,I_> x1 = x;
	return generic_fract(x1);
}
//fract for ap_uint
template <int I_>
ap_uint<I_> generic_fract(ap_uint<I_> x){
	ap_ufixed<I_,I_> x1 = x;
	return generic_fract(x1);
}
}
#endif


