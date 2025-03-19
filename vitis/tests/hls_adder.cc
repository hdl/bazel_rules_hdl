#include "hls_adder.h"

namespace vitis {

void adder(fixed &a, fixed &b, fixed &c) {
#pragma HLS pipeline II = 1
  c = a + b;
}

}  // namespace vitis