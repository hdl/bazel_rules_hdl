"""Module extensions for HDL tools."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def _tools_extension_impl(module_ctx):
    # Yosys
    maybe(
        http_archive,
        name = "at_clifford_yosys",
        urls = [
            "https://github.com/YosysHQ/yosys/archive/8f07a0d8404f63349d8d3111217b73c9eafbd667.zip",
        ],
        sha256 = "46a9a4d969770fa20a2fd12c8e83307a597126609645c9655c370c0c365da344",
        strip_prefix = "yosys-8f07a0d8404f63349d8d3111217b73c9eafbd667",
        build_file = "//dependency_support/at_clifford_yosys:bundled.BUILD.bazel",
        patches = [
            "//dependency_support/at_clifford_yosys:yosys.patch",
            "//dependency_support/at_clifford_yosys:autoname.patch",
        ],
    )

    # Icarus Verilog
    maybe(
        http_archive,
        name = "com_icarus_iverilog",
        urls = [
            "https://github.com/steveicarus/iverilog/archive/v12_0.tar.gz",
        ],
        strip_prefix = "iverilog-12_0",
        sha256 = "a68cb1ef7c017ef090ebedb2bc3e39ef90ecc70a3400afb4aa94303bc3beaa7d",
        build_file = "//dependency_support/com_icarus_iverilog:bundled.BUILD.bazel",
    )

    # Verilator
    maybe(
        http_archive,
        name = "verilator",
        urls = ["https://github.com/verilator/verilator/archive/v5.050.tar.gz"],
        sha256 = "ec6723f30c1798b1fbbbed97364f09c431fb4875577c314f37240e99b60a4a04",
        strip_prefix = "verilator-5.050",
        build_file = "//dependency_support/verilator:verilator.BUILD.bazel",
    )

    # lz4
    maybe(
        http_archive,
        name = "net_lz4",
        urls = ["https://github.com/lz4/lz4/releases/download/v1.10.0/lz4-1.10.0.tar.gz"],
        strip_prefix = "lz4-1.10.0",
        sha256 = "537512904744b35e232912055ccf8ec66d768639ff3abe5788d90d792ec5f48b",
        build_file = "//dependency_support/net_lz4:net_lz4.BUILD.bazel",
    )

    return module_ctx.extension_metadata(
        root_module_direct_deps = ["at_clifford_yosys", "com_icarus_iverilog", "verilator", "net_lz4"],
        root_module_direct_dev_deps = [],
    )

tools_extension = module_extension(
    implementation = _tools_extension_impl,
    tag_classes = {
        "use_toolchain": tag_class(
            attrs = {
                "name": attr.string(mandatory = True),
            },
        ),
    },
)
