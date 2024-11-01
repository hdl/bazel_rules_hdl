# Copyright 2021 Google LLC
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

"""Describe Verilog providers and some helpful functions for manipulating them."""

# WARNING: prefer using 'merge_verilog_info' rather than constructing these directly
# to ensure the depset ordering is correct.
VerilogInfo = provider(
    doc = "Contains DAG info per node in a struct.",
    fields = {
        "dag": "A depset of the DAG entries to propagate upwards.",
        "plis": "a depset of VerilogInterfaceInfo",
    },
)

def make_dag_entry(srcs, hdrs, data, deps, label, tags):
    """Create a new DAG entry for use in VerilogInfo.

    As VerilogInfo should be created via 'merge_verilog_info' (rather than directly),
    the new entries being passed in should be created with this function in order to
    ensure the struct contains the correct fields.

    Any fields marked 'legacy' are under immediate plans to be deprecated. New uses
    should be avoided. Fields marked as 'experimental' are more likely to experience
    changes in semantics in the future. Future users should exercise caution before
    using them and consider consulting the rule maintainers first.

    Args:
      srcs: A list of File that are 'srcs'.
      hdrs: A list of File that are 'hdrs'.
      data: A list of File that are `data`.
      deps: A list of Label that are deps of this entry.
      label: A Label to use as the name for this entry.
      tags: A list of str. (Ideally) just the entry tags for later filelist filtering.
    Returns:
      struct with all these fields properly stored.
    """
    return struct(
        srcs = tuple(srcs),
        hdrs = tuple(hdrs),
        data = tuple(data),
        deps = tuple(deps),
        tags = tuple(tags),
        label = label,
    )

def make_verilog_info(
        new_entries = (),
        old_infos = ()):
    """Return a new VerilogInfo that merges other VerilogInfo and new DAG entries.

    WARNING: Prefer using this function instead of manually creating or merging
    VerilogInfo providers to ensure the DAG traversal ordering is correct.

    Note: It is expected that the new DAG entries point to entries in the other
    VerilogInfo (but this is not required or enforced).

    Args:
      new_entries: list of DAG entries (from 'make_dag_entry') to add to the DAG
      old_infos: list of VerilogInfo that hold other parts of the DAG
      # plis: Verilog PLI/VPI files.
      # dpis: Verilog DPI files.
    Returns:
      VerilogInfo that combines all the DAGs together.
    """
    return VerilogInfo(
        dag = depset(
            direct = new_entries,
            order = "postorder",
            transitive = [x.dag for x in old_infos],
        ),
    )

def _verilog_library_impl(ctx):
    """Produces a DAG for the given verilog_X target.

    Args:
      ctx: The context for this rule.

    Returns:
      A struct containing the DAG at this level of the dependency graph.
    """

    verilog_info = make_verilog_info(
        new_entries = [make_dag_entry(
            srcs = ctx.files.srcs,
            data = ctx.files.data,
            hdrs = ctx.files.hdrs,
            deps = ctx.attr.deps,
            label = ctx.label,
            tags = [],
        )],
        old_infos = [dep[VerilogInfo] for dep in ctx.attr.deps],
    )

    return [
        verilog_info,
    ]

verilog_library = rule(
    doc = "Define a Verilog module.",
    implementation = _verilog_library_impl,
    attrs = {
        "data": attr.label_list(
            doc = "Compile data ready by sources.",
            allow_files = True,
        ),
        "deps": attr.label_list(
            doc = "The list of other libraries to be linked.",
            providers = [
                VerilogInfo,
            ],
        ),
        "hdrs": attr.label_list(
            doc = "Verilog or SystemVerilog headers.",
            allow_files = [".vh", ".svh"],
        ),
        "srcs": attr.label_list(
            doc = "Verilog or SystemVerilog sources.",
            allow_files = [".v", ".sv"],
        ),
    },
)
