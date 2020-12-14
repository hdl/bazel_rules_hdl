# The structure for adding a third_party dependency is to create a folder in this
# directory that will contain the build rules and workspace rules required to import
# it.
load("//dependency_support/yosys:yosys.bzl", "yosys")


def dependency_support():
  yosys()
