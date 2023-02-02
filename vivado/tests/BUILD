load("//verilog:providers.bzl", "verilog_library")
load("//verilator:defs.bzl", "verilator_cc_library")
load(
    "//vivado:defs.bzl",
    "vivado_flow",
    "xsim_test",
    "vivado_create_ip",
    "vivado_create_project",
)

verilog_library(
    name = "johnson_counter",
    srcs = [
        "johnson_counter.sv",
        "test.mem",
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

py_binary(
    name = "gen_values",
    srcs = ["gen_values.py"]
)

genrule(
    name = "test_mem",
    outs = ["test.mem"],
    tools = [":gen_values"],
    cmd = "$(location :gen_values) > $(OUTS)",
)

verilog_library(
    name = "weights_replay",
    srcs = [
        "weights_replay.sv",
        "test.mem",
    ],
)

verilator_cc_library(
    name = "weights_replay_verilator",
    module = ":weights_replay",
    module_top = "weights_replay",
)

cc_test(
    name = "weights_replay_test",
    srcs = ["weights_replay_test.cc"],
    data =[
        "test.mem",
    ],
    deps = [
        ":weights_replay_verilator",
        "@com_google_googletest//:gtest_main",
    ],
)

verilog_library(
    name = "weights_replay_top",
    srcs = [
        "weights_replay_top.sv",
        "zcu111_weights.tcl",
    ],
)

vivado_create_ip(
    name = "weights_replay_ip",
    module = ":weights_replay",
    module_top = "weights_replay",
    part_number = "xczu28dr-ffvg1517-2-e",
    ip_version = "0.1",
    ip_library = "test",
    ip_vendor = "test_vendor",
    tags = ["manual"],
    xilinx_env = ":xilinx_env.sh",
)

vivado_flow(
    name = "weights_replay_vivado",
    module = ":weights_replay_top",
    module_top = "weights_replay_top",
    part_number = "xczu28dr-ffvg1517-2-e",
    ip_blocks = [
        ":weights_replay_ip",
    ],
    tags = ["manual"],
    xilinx_env = ":xilinx_env.sh",
)

vivado_create_project(
    name = "weights_replay_project",
    module = ":weights_replay_top",
    module_top = "weights_replay_top",
    part_number = "xczu28dr-ffvg1517-2-e",
    ip_blocks = [
        ":weights_replay_ip",
    ],
    tags = ["manual"],
    xilinx_env = ":xilinx_env.sh",
)

