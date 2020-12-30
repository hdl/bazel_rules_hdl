# Python toolchain

This repository includes a hermetically packaged Python toolchain because the CI
builders have a very old (3.5) Python installed. The binaries are from
[Python Standalone Builds](https://github.com/indygreg/python-build-standalone),
but are repackaged because the official releases from that repository use zst
compression which is not supported by Bazel.
