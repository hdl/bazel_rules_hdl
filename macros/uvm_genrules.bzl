""" Generates a rule for a UVM test. """

load("sim_genrules.bzl", "sim_run")

def uvm_test(
        module,
        name,
        uvm_test,
        uvm_seq,
        uvm_scb = "",
        simulators = ["verilator"],
        extra_bazel_tags = []):
    """Generates a rule for running a UVM test.

    Args:
        module: name of the simulated verilog_library
        name: test name
        uvm_test: name of the UVM test
        uvm_seq: name of the UVM sequence
        uvm_scb: name of the UVM scoreboard to use
        simulators: simulator (verilator)
        extra_bazel_tags: extra tags to be placed for bazel target definition
    """

    # Generate run targets
    args = [
        "+UVM_TESTNAME=" + uvm_test,
        "+UVM_TEST_SEQ=" + uvm_seq,
        "+UVM_NO_RELNOTES",

        # Disable log on not finished assertions
        "-assert",
        "nopostproc",
    ]

    if uvm_scb != "":
        args.append("+UVM_TEST_SCB=" + uvm_scb)

    sim_run(
        module = module,
        suffix = name,
        simulators = simulators,
        extra_verilator_args = args,
        extra_bazel_tags = extra_bazel_tags,
    )
