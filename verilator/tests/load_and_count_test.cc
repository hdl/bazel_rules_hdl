#include <verilated.h>
#include <verilated_vcd_c.h>

#include <memory>

#include "Vload_and_count.h"
#include "gtest/gtest.h"

namespace {

class LoadAndCountTest : public testing::Test {
 protected:
  void Clock(Vload_and_count* v_load_and_count) {
    v_load_and_count->clk = 0;
    v_load_and_count->eval();
    v_load_and_count->clk = 1;
    v_load_and_count->eval();
  }
};

TEST_F(LoadAndCountTest, count_three_times) {
  std::unique_ptr<Vload_and_count> v_load_and_count =
      std::make_unique<Vload_and_count>();
  v_load_and_count->eval();
  EXPECT_EQ(v_load_and_count->counter_value, 0xA5B6);
  Clock(v_load_and_count.get());
  EXPECT_EQ(v_load_and_count->counter_value, 0xA5B7);
  Clock(v_load_and_count.get());
  EXPECT_EQ(v_load_and_count->counter_value, 0xA5B8);
}

}  // namespace
