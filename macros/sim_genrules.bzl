""" Generates simulation rules"""

load("//macros:log_test.bzl", "log_test")
load("//verilator:defs.bzl", "verilator_cc_binary", "verilator_run")

_DEFAULT_COVERAGE = select({
    Label("//macros:coverage_is_none"): "none",
    Label("//macros:coverage_is_all"): "all",
    "//conditions:default": "none",
})

_VERILATOR_VOPTS = [
    "--O3",
    "-Wno-WIDTHTRUNC",
    "-Wno-WIDTHEXPAND",
    "-Wno-TIMESCALEMOD",
    "--timing",
]

def sim_build(
        module,
        top = "tb",
        simulators = ["verilator"],
        name = None,
        trace_vcd = False,
        extra_verilator_args = [],
        extra_bazel_tags = [],
        coverage = _DEFAULT_COVERAGE):
    """Generate rules for building (compiling) a simulation.

    Args:
        module: name of the simulated verilog_library
        top: name of the top module
        name: base name for generated simulation targets; defaults to the module name
        simulators: simulator (verilator)
        trace_vcd: controls whether VCD tracing is enabled in the binary
        extra_verilator_args: extra compilation options for Verilator
        extra_bazel_tags: extra tags to be placed for bazel target definition
        coverage: types of coverage to collect
    """

    # Convert module name to a Label object
    module = native.package_relative_label(module)

    if (name == None):
        name = module.name

    # Verilator
    if "verilator" in simulators:
        verilator_cc_binary(
            name = name + "_verilator_bin",
            copts = [
                "-std=c++20",
            ],
            coverage = coverage,
            module = module,
            module_top = top,
            trace = trace_vcd,
            visibility = [
                "//visibility:public",
            ],
            vopts = _VERILATOR_VOPTS + extra_verilator_args,
            tags = ["verilator_tb_build"] + extra_bazel_tags,
        )

def sim_run(
        module,
        suffix = "",
        simulators = ["verilator"],
        name = None,
        extra_verilator_args = [],
        extra_bazel_tags = []):
    """Generate rules for running a simulation.

    Args:
        module: name of the simulated verilog_library
        suffix: a suffix to append after the generated target base name
        simulators: simulator (verilator)
        name: base name for generated simulation targets; defaults to the module name
        extra_verilator_args: extra runtime options for Verilator
        extra_bazel_tags: extra tags to be placed for bazel target definition
    """

    # Convert module name to a Label object
    module = native.package_relative_label(module)
    if name == None:
        name = module.name

    # Fixup suffix
    if suffix != "":
        suffix = "_" + suffix

    # Verilator
    if "verilator" in simulators:
        verilator_run(
            name = name + suffix + "_verilator_run",
            binary = name + "_verilator_bin",
            trace_plusarg = "vcd",
            visibility = [
                "//visibility:public",
            ],
            args = extra_verilator_args,
            tags = ["verilator_tb_run"] + extra_bazel_tags,
        )

        log_test(
            name = name + suffix + "_verilator_run_check",
            log = name + suffix + "_verilator_run",
            visibility = [
                "//visibility:public",
            ],
            tags = ["verilator_tb_run_check"] + extra_bazel_tags,
        )

def sim_genrules(
        module,
        top = "tb",
        simulators = ["verilator"],
        name = None,
        trace_vcd = False,
        extra_verilator_run_args = [],
        extra_verilator_binary_vopts = [],
        extra_bazel_tags = [],
        coverage = _DEFAULT_COVERAGE):
    """Generate rules for simulations.

    Args:
        module: name of the simulated verilog_library
        top: name of the top module
        simulators: simulator (verilator)
        name: base name for generated simulation targets; defaults to the module name
        trace_vcd: controls whether VCD traces should be generated
        extra_verilator_run_args: extra runtime options for Verilator
        extra_verilator_binary_vopts: extra compilation options for Verilator
        extra_bazel_tags: extra tags to be placed for bazel target definition
        coverage: types of coverage to collect
    """

    # Generate build targets
    sim_build(
        module = module,
        top = top,
        simulators = simulators,
        name = name,
        trace_vcd = trace_vcd,
        extra_verilator_args = extra_verilator_binary_vopts,
        extra_bazel_tags = extra_bazel_tags,
        coverage = coverage,
    )

    # Generate run targets
    sim_run(
        module = module,
        simulators = simulators,
        name = name,
        extra_verilator_args = extra_verilator_run_args,
        extra_bazel_tags = extra_bazel_tags,
    )
