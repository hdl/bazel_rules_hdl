"""verilog rules"""

load(
    ":providers.bzl",
    _VerilogInfo = "VerilogInfo",
    _verilog_library = "verilog_library",
)

VerilogInfo = _VerilogInfo
verilog_library = _verilog_library
