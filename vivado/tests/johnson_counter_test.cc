#include <verilated.h>
#include <verilated_vcd_c.h>

#include <memory>

#include "Vjohnson_counter.h"
#include "gtest/gtest.h"

namespace {

constexpr int kCounterBits = 3;

class JohnsonCounterTest : public testing::Test {
 protected:
  void Clock(Vjohnson_counter* v_johnson_counter) {
    v_johnson_counter->clk = 0;
    v_johnson_counter->eval();
    v_johnson_counter->clk = 1;
    v_johnson_counter->eval();
    if (!v_johnson_counter->rst) {
      cycles_since_reset_ += 1;
    }
  }

  void SetReset(Vjohnson_counter* v_johnson_counter, bool reset) {
    v_johnson_counter->direction = 1;
    if (reset) {
      cycles_since_reset_ = 0;
    }
    v_johnson_counter->rst = reset;
  }

  int GetExpectedValue() {
    // Register state starts at all zeros.
    // Assume that 'direction = 1'.
    // Sequence is 0x00, 0x01, 0x03, ... 0xFF, 0xFE, 0xFC, ... 0x80, 0x00
    // Moves to the next step in sequence every 8 cycles.

    // The sequence repeats every 16 counts.
    int sequence_index = (cycles_since_reset_ >> 3) % 16;
    // Shift in and then out the ones as needed.
    // The output is expected_value[15:8];
    int expected_value = (0xFF << sequence_index);
    expected_value = (expected_value >> 8);
    return expected_value & 0xFF;
  }

 private:
  int cycles_since_reset_;
};

TEST_F(JohnsonCounterTest, content) {
  std::unique_ptr<Vjohnson_counter> v_johnson_counter =
      std::make_unique<Vjohnson_counter>();

  SetReset(v_johnson_counter.get(), true);
  for (int cycles = 0; cycles < 5; cycles++) {
    Clock(v_johnson_counter.get());
  }

  // Run a few iterations.
  const int kNumCycles = (1 << kCounterBits) * 32;
  SetReset(v_johnson_counter.get(), false);

  for (int cycles = 0; cycles < kNumCycles; cycles++) {
    Clock(v_johnson_counter.get());
    EXPECT_EQ(v_johnson_counter->shift_reg, GetExpectedValue());
  }
}

}  // namespace
