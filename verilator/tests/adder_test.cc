#include <verilated.h>
#include <verilated_vcd_c.h>

#include <memory>

#include "Vadder.h"
#include "gtest/gtest.h"

namespace {

class AdderTest : public testing::Test {};

TEST_F(AdderTest, one_plus_two) {
  std::unique_ptr<Vadder> v_adder = std::make_unique<Vadder>();
  v_adder->x = 1;
  v_adder->y = 2;
  v_adder->eval();
  EXPECT_EQ(v_adder->sum, 3);
}

}  // namespace
