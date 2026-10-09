"""Verilog filelist generation rules"""

load("@rules_pkg//pkg:providers.bzl", "PackageFilesInfo")
load(":providers.bzl", "VerilogInfo")

def _flatten_verilog_info(providers):
    infos = depset([], transitive = [p.dag for p in providers]).to_list()

    # Flatten
    srcs = [info.srcs for info in infos]
    hdrs = [info.hdrs for info in infos]

    srcs = [f for sub_tuple in srcs for f in sub_tuple]
    hdrs = [f for sub_tuple in hdrs for f in sub_tuple]

    return (srcs, hdrs)

def _verilog_filelist_impl(ctx):
    (srcs, hdrs) = _flatten_verilog_info([d[VerilogInfo] for d in ctx.attr.deps])

    # Create inverted map
    src_dest_map = {}
    if ctx.attr.pkg_files:
        src_dest_map = {src: dest for (dest, src) in ctx.attr.pkg_files[PackageFilesInfo].dest_src_map.items()}

    # Map hdrs
    include_dirs = []
    for h in hdrs:
        if h in src_dest_map:
            # It's safe to rely on a path sepparator, because rules_pkg uses /
            include_dirs.append(src_dest_map[h].rsplit("/", 1)[0])
        else:
            include_dirs.append(h.dirname)
    include_dirs = depset(include_dirs).to_list()

    # Map srcs
    src_paths = []
    for s in srcs:
        if s in src_dest_map:
            src_paths.append(src_dest_map[s])
        else:
            src_paths.append(s.path)

    # Write the .f file
    content = []
    for name in include_dirs:
        content.append(ctx.attr.include_prefix + name)
    content.extend(src_paths)

    filelist = ctx.attr.filelist
    if not filelist:
        filelist = ctx.label.name + ".f"

    file = ctx.actions.declare_file(filelist)
    ctx.actions.write(file, "\n".join(content) + "\n")

    return DefaultInfo(
        files = depset([file]),
    )

verilog_filelist = rule(
    doc = "Generate a .f file from a Verilog library.",
    implementation = _verilog_filelist_impl,
    attrs = {
        "deps": attr.label_list(
            doc = "The Verilog libraries to use",
            providers = [VerilogInfo],
            mandatory = True,
        ),
        "filelist": attr.string(
            doc = "Name of the file containing filelist, by default it's label.name+\".f\"",
        ),
        "include_prefix": attr.string(
            doc = "Prefix for include directories",
            default = "+incdir+",
        ),
        "pkg_files": attr.label(
            doc = "Target collecting files to provide proper mapping",
            providers = [PackageFilesInfo],
        ),
    },
    provides = [
        DefaultInfo,
    ],
)
