
#ifdef __SYNTHESIS__
#include <ap_fixed.h>
#else
#ifdef WITH_VIVADO_HLS
#include "vitis/v2020_1/ap_fixed.h"
#else
#include "vitis/v2021_2/ap_fixed.h"
#endif
#endif

#include "vitis/tests/consts.h"
namespace vitis {

typedef ap_fixed<16, 9> fixed;

void adder(fixed &a, fixed &b, fixed &c);

}  // namespace vitis