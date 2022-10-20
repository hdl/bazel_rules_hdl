load("//verilog:providers.bzl", "verilog_library")
load("//verilator:defs.bzl", "verilator_cc_library")
load(
    "//vivado:defs.bzl",
    "vivado_flow",
    "xsim_test",
)

verilog_library(
    name = "johnson_counter",
    srcs = [
        "johnson_counter.sv",
    ],
)

verilator_cc_library(
    name = "johnson_counter_verilator",
    module = ":johnson_counter",
    module_top = "johnson_counter",
)

cc_test(
    name = "johnson_counter_test",
    srcs = ["johnson_counter_test.cc"],
    deps = [
        ":johnson_counter_verilator",
        "@com_google_googletest//:gtest_main",
    ],
)

verilog_library(
    name = "xsim_smoke_tb",
    srcs = ["xsim_smoke_tb.sv"],
)

xsim_test(
    name = "xsim_smoke_test",
    module = ":xsim_smoke_tb",
    module_top = "xsim_smoke_tb",
    part_number = "xczu28dr-ffvg1517-2-e",
    tags = ["manual"],
    with_waveform = True,
    xilinx_env = ":xilinx_env.sh",
)

verilog_library(
    name = "johnson_counter_top",
    srcs = [
        "io_constraints.xdc",
        "johnson_counter_top.sv",
        "zcu111_gpio.tcl",
    ],
    deps = [
        ":johnson_counter",
    ],
)

vivado_flow(
    name = "johnson_counter_vivado",
    module = ":johnson_counter_top",
    module_top = "johnson_counter_top",
    part_number = "xczu28dr-ffvg1517-2-e",
    tags = ["manual"],
    xilinx_env = ":xilinx_env.sh",
)
