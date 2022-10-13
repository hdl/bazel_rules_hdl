#include <verilated.h>
#include <verilated_vcd_c.h>

#include <memory>

#include "Vnested_module_2.h"
#include "gtest/gtest.h"

namespace {

class NestedModuleTest : public testing::Test {
 protected:
  void Clock(Vnested_module_2* v_nested_module_2) {
    v_nested_module_2->clk = 0;
    v_nested_module_2->eval();
    v_nested_module_2->clk = 1;
    v_nested_module_2->eval();
  }
};

TEST_F(NestedModuleTest, test_all) {
  std::unique_ptr<Vnested_module_2> v_nested_module_2 =
      std::make_unique<Vnested_module_2>();
  // Run for 11 clock cycles, 8 test values and 3 cycles to propogate.
  for (int i = 0; i < 11; i++) {
    v_nested_module_2->input_val = i % 8;
    Clock(v_nested_module_2.get());
    if (i > 2) {
      EXPECT_EQ(v_nested_module_2->output_val, (~(i - 2)) & 0x7);
    }
  }
}

}  // namespace
