#include "hls_adder.h"

#include "gtest/gtest.h"

namespace vitis {
namespace {

class HlsAdderTest : public testing::Test {};

TEST_F(HlsAdderTest, one_plus_one) {
  fixed a = 1;
  fixed b = 1;
  fixed c;
  adder(a, b, c);
  EXPECT_EQ(c, 2);
}

TEST_F(HlsAdderTest, quarter_plus_quarter) {
  fixed a = 0.25;
  fixed b = 0.25;
  fixed c;
  adder(a, b, c);
  EXPECT_EQ(c, 0.5);
}

}  // namespace
}  // namespace vitis