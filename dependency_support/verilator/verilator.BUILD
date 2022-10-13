# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Original implementation by Kevin Kiningham (@kkiningh) in kkiningh/rules_verilator.
# Ported to bazel_rules_hdl by Stephen Tridgell (@stridge-cruxml)

load("@rules_hdl//dependency_support/com_github_westes_flex:flex.bzl", "genlex")

package(default_visibility = ["//visibility:private"])

licenses(["notice"])

exports_files([
    "Artistic",
    "COPYING",
    "COPYING.LESSER",
])

sh_binary(
    name = "flexfix",
    srcs = ["src/flexfix"],
)

sh_binary(
    name = "bisonpremod",
    srcs = ["src/bisonpremod"],
)

genrule(
    name = "verilator_astgen",
    srcs = [
        "src/V3Ast.h",
        "src/V3AstNodes.h",
        "src/Verilator.cpp",
        "src/astgen",
    ],
    outs = [
        "V3Ast__gen_classes.h",
        "V3Ast__gen_impl.h",
        "V3Ast__gen_report.txt",
        "V3Ast__gen_types.h",
        "V3Ast__gen_visitor.h",
        "V3Ast__gen_yystype.h",
        "V3AstNodes__gen_macros.h",
    ],
    cmd = """
    python3 $(location src/astgen) -I $$(dirname $(location src/V3Ast.h)) --classes
    cp V3Ast__gen_classes.h $(@D)
    cp V3Ast__gen_impl.h $(@D)
    cp V3Ast__gen_report.txt $(@D)
    cp V3Ast__gen_types.h $(@D)
    cp V3Ast__gen_visitor.h $(@D)
    cp V3Ast__gen_yystype.h $(@D)
    cp V3AstNodes__gen_macros.h $(@D)
    """,
)

genrule(
    name = "verilator_astgen_const",
    srcs = [
        "src/V3Ast.h",
        "src/V3AstNodes.h",
        "src/V3Const.cpp",
        "src/Verilator.cpp",
        "src/astgen",
    ],
    outs = ["V3Const__gen.cpp"],
    cmd = """
    python3 $(location src/astgen) -I $$(dirname $(location src/V3Const.cpp)) V3Const.cpp
    cp V3Const__gen.cpp $(@D)
    """,
)

genlex(
    name = "verilator_lex_pregen",
    src = "src/verilog.l",
    out = "V3Lexer_pregen.yy.cpp",
)

genrule(
    name = "verilator_lex_flexfix",
    srcs = [":V3Lexer_pregen.yy.cpp"],
    outs = ["V3Lexer.yy.cpp"],
    cmd = "./$(location :flexfix) V3Lexer < $(<) > $(@)",
    tools = [":flexfix"],
)

genlex(
    name = "verilator_prelex_pregen",
    src = "src/V3PreLex.l",
    out = "V3PreLex_pregen.yy.cpp",
)

genrule(
    name = "verilator_prelex_flexfix",
    srcs = [":V3PreLex_pregen.yy.cpp"],
    outs = ["V3PreLex.yy.cpp"],
    cmd = "./$(location :flexfix) V3PreLex < $(<) > $(@)",
    tools = [":flexfix"],
)

genrule(
    name = "verilator_bison",
    srcs = [
        "src/verilog.y",
        "@org_gnu_bison//:data",
    ],
    outs = [
        "V3ParseBison.c",
        "V3ParseBison.h",
    ],
    cmd = "M4=$(location @org_gnu_m4//:m4) BISON_PKGDATADIR=$(location @org_gnu_bison//:data) ./$(location :bisonpremod)" +
          " --yacc $(location @org_gnu_bison//:bison) -d -v -o $(location V3ParseBison.c) $(location src/verilog.y)",
    tools = [
        ":bisonpremod",
        "@org_gnu_bison//:bison",
        "@org_gnu_m4//:m4",
    ],
)

cc_library(
    name = "verilatedos",
    hdrs = ["include/verilatedos.h"],
    strip_include_prefix = "include/",
)

# Helper lib to break dependency between V3 and libverilated
cc_library(
    name = "verilated_trace_defs",
    hdrs = ["include/verilated_trace_defs.h"],
    strip_include_prefix = "include/",
)

# TODO(kkiningh): Verilator also supports multithreading, should we enable it?
cc_library(
    name = "verilator_libV3",
    srcs = glob(
        ["src/V3*.cpp"],
        exclude = [
            "src/V3*_test.cpp",
            "src/V3Const.cpp",
        ],
    ) + [
        ":V3Ast__gen_classes.h",
        ":V3Ast__gen_impl.h",
        ":V3Ast__gen_types.h",
        ":V3Ast__gen_visitor.h",
        ":V3AstNodes__gen_macros.h",
        ":V3Ast__gen_yystype.h",
        ":V3Const__gen.cpp",
        ":V3ParseBison.h",
    ],
    hdrs = glob(["src/V3*.h"]) + [
        "src/config_build.h",
        "src/config_rev.h",
    ],
    copts = [
        # TODO: We should probably set this later
        "-DDEFENV_SYSTEMC_INCLUDE=\\\"@invalid@\\\"",
        "-DDEFENV_SYSTEMC_LIBDIR=\\\"@invalid@\\\"",
        "-DDEFENV_VERILATOR_ROOT=\\\"@invalid@\\\"",
        # TODO: Remove these once upstream fixes these warnings
        "-Wno-unneeded-internal-declaration",
    ],
    defines = ["YYDEBUG"],
    strip_include_prefix = "src/",
    textual_hdrs = [
        # These are included directly by other C++ files
        # See https://github.com/bazelbuild/bazel/issues/680
        ":V3Lexer.yy.cpp",
        ":V3PreLex.yy.cpp",
        ":V3ParseBison.c",
    ],
    deps = [
        ":verilated_trace_defs",  # Needed for V3TraceDecl.cpp
        ":verilatedos",
        "@com_github_westes_flex//:FlexLexer",
    ],
)

cc_library(
    name = "libverilator",
    srcs = [
        "include/gtkwave/fastlz.h",
        "include/gtkwave/fst_config.h",
        "include/gtkwave/fstapi.h",
        "include/gtkwave/lz4.h",
        "include/gtkwave/wavealloca.h",
        "include/verilated.cpp",
        "include/verilated_fst_c.cpp",
        "include/verilated_imp.h",
        "include/verilated_syms.h",
        "include/verilated_vcd_c.cpp",
    ],
    hdrs = [
        "include/verilated.h",
        "include/verilated_config.h",
        "include/verilated_dpi.h",
        "include/verilated_fst_c.h",
        "include/verilated_heavy.h",
        "include/verilated_intrinsics.h",
        "include/verilated_sc.h",
        "include/verilated_sym_props.h",
        "include/verilated_trace.h",
        "include/verilated_trace_defs.h",
        # Needed for verilated_vcd_c.cpp and verilated_fst_c.cpp
        "include/verilated_trace_imp.h",
        "include/verilated_vcd_c.h",
        "include/verilatedos.h",
        "include/verilated_types.h",
        "include/verilated_funcs.h",
    ],
    # TODO: Remove these once upstream fixes these warnings
    copts = ["-Wno-unused-const-variable"],
    includes = ["include"],
    strip_include_prefix = "include/",
    textual_hdrs = [
        "include/gtkwave/fastlz.c",
        "include/gtkwave/fstapi.c",
        "include/gtkwave/lz4.c",
    ],
    visibility = ["//visibility:public"],
    deps = [
        "@net_zlib//:zlib",
    ],
)

cc_library(
    name = "svdpi",
    hdrs = [
        "include/vltstd/svdpi.h",
    ],
    strip_include_prefix = "include/vltstd",
    visibility = ["//visibility:public"],
)

cc_binary(
    name = "verilator_executable",
    srcs = ["src/Verilator.cpp"],
    visibility = ["//visibility:public"],
    deps = [":verilator_libV3"],
)
