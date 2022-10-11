load("//verilog:providers.bzl", "verilog_library")
load("//verilator:defs.bzl", "verilator_cc_library")

verilog_library(
    name = "adder",
    srcs = [
        "adder.sv",
    ],
)

verilator_cc_library(
    name = "adder_verilator",
    module = ":adder",
)

cc_test(
    name = "adder_test",
    srcs = ["adder_test.cc"],
    deps = [
        ":adder_verilator",
        "@com_google_googletest//:gtest_main",
    ]
)