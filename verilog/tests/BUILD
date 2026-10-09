load("//verilog:defs.bzl", "verilog_filelist", "verilog_library")

package(
    default_applicable_licenses = ["//:package_license"],
    default_visibility = ["//visibility:private"],
)

verilog_library(
    name = "not",
    srcs = [
        "not.v",
    ],
)

verilog_library(
    name = "top",
    srcs = [
        "top.v",
    ],
    hdrs = [
        "defs.vh",
    ],
    deps = [
        ":not",
    ],
)

verilog_filelist(
    name = "top_filelist",
    deps = [
        ":top",
    ],
)

genrule(
    name = "top_filelist_test",
    srcs = [
        "golden.f",
        ":top_filelist",
    ],
    outs = ["diff.txt"],
    cmd = "diff $(SRCS) > $(OUTS)",
)
