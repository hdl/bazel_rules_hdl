# Embedded Python interpreter

Unlike most other directories under `dependency_support`, this package doesn't
download a external source. Instead it exposes the
`@rules_hdl//dependency_support/embedded_python_interpreter` target, which C++
targets can depend on to get access to Python symbols. This points to the Python
libraries that are provided by the Python interpreter that is used by Bazel.
