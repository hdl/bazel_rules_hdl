# Copyright 2020 Google LLC
#
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

"""Build rule for generating C or C++ sources with Bison.
"""

def _genyacc_impl(ctx):
    """Implementation for genyacc rule."""

    # Argument list
    args = ctx.actions.args()
    args.add("--defines=%s" % ctx.outputs.header_out.path)
    args.add("--output-file=%s" % ctx.outputs.source_out.path)
    if ctx.attr.prefix:
        args.add("--name-prefix=%s" % ctx.attr.prefix)
    args.add_all([ctx.expand_location(opt) for opt in ctx.attr.extra_options])
    args.add(ctx.file.src.path)

    # Output files
    outputs = ctx.outputs.extra_outs + [
        ctx.outputs.header_out,
        ctx.outputs.source_out,
    ]

    ctx.actions.run(
        executable = ctx.executable._bison,
        env = {
            "BISON_PKGDATADIR": ctx.attr._bison_data_path.files.to_list()[0].path,
            "M4": ctx.executable._m4.path,
        },
        arguments = [args],
        inputs = ctx.files._bison_data + ctx.files.src,
        tools = [ctx.executable._m4],
        outputs = outputs,
        mnemonic = "Yacc",
        progress_message = "Generating %s and %s from %s" %
                           (
                               ctx.outputs.source_out.short_path,
                               ctx.outputs.header_out.short_path,
                               ctx.file.src.short_path,
                           ),
    )

genyacc = rule(
    implementation = _genyacc_impl,
    doc = "Generate C/C++-language sources from a Yacc file using Bison.",
    attrs = {
        "extra_options": attr.string_list(
            doc = "A list of extra options to pass to Bison.  These are " +
                  "subject to $(location ...) expansion.",
        ),
        "extra_outs": attr.output_list(
            doc = "A list of extra generated output files.",
        ),
        "header_out": attr.output(
            mandatory = True,
            doc = "The generated 'defines' header file",
        ),
        "prefix": attr.string(
            doc = "External symbol prefix for Bison. This string is " +
                  "passed to bison as the -p option, causing the resulting C " +
                  "file to define external functions named 'prefix'parse, " +
                  "'prefix'lex, etc. instead of yyparse, yylex, etc.",
        ),
        "source_out": attr.output(
            mandatory = True,
            doc = "The generated source file",
        ),
        "src": attr.label(
            mandatory = True,
            allow_single_file = [".y", ".yy", ".yc", ".ypp", ".yxx"],
            doc = "The .y, .yy, or .yc source file for this rule",
        ),
        "_bison": attr.label(
            default = Label("@org_gnu_bison//:bison"),
            executable = True,
            cfg = "exec",
        ),
        "_bison_data": attr.label(
            default = Label("@org_gnu_bison//:bison_runtime_data"),
        ),
        "_bison_data_path": attr.label(
            default = Label("@org_gnu_bison//:data"),
            allow_single_file = True,
        ),
        "_m4": attr.label(
            default = Label("@org_gnu_m4//:m4"),
            executable = True,
            cfg = "exec",
        ),
    },
    output_to_genfiles = True,
)
