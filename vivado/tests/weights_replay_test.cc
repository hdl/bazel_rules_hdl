#include <iostream>
#include <fstream>
#include <string>
#include <memory>

#include <verilated.h>
#include <verilated_vcd_c.h>

#include "Vweights_replay.h"
#include "gtest/gtest.h"

namespace {

constexpr int kCounterBits = 3;

class WeightsReplayTest : public testing::Test {
 protected:
  void Clock(Vweights_replay* v_weights_replay, int n = 1) {
    for (int i = 0; i < n; i++) {
        v_weights_replay->clk = 0;
        v_weights_replay->eval();
        v_weights_replay->clk = 1;
        v_weights_replay->eval();
    }
  }

  void SetReset(Vweights_replay* v_weights_replay, bool reset) {
    v_weights_replay->rst = reset;
  }
};

TEST_F(WeightsReplayTest, load_and_compare) {
  std::unique_ptr<Vweights_replay> v_weights_replay =
      std::make_unique<Vweights_replay>();

  std::string line;
  std::vector<int> expected_values;
  // Read the weights file to compare against.
  std::ifstream file("vivado/tests/test.mem");
  EXPECT_TRUE(file.is_open());
  while (std::getline(file, line)) {
    int x = std::stoi(line, nullptr, 16);
    expected_values.push_back(x);
  }
  EXPECT_EQ(expected_values.size(), 8);

  SetReset(v_weights_replay.get(), true);
  Clock(v_weights_replay.get(), 5);

  // Run a few iterations.
  const int kNumCycles = (1 << kCounterBits) * expected_values.size() * 2;
  SetReset(v_weights_replay.get(), false);

  int expected_values_index = 0;
  for (int cycles = 0; cycles < kNumCycles; cycles++) {
    Clock(v_weights_replay.get());
    EXPECT_EQ(v_weights_replay->shift_reg, expected_values[expected_values_index]) << cycles;
    if (cycles % (1 << kCounterBits) == (1 << kCounterBits) - 1) {
      expected_values_index = (expected_values_index + 1) % expected_values.size();
    }
  }
}

}  // namespace
