"""verilog rules"""

load(
    ":providers.bzl",
    _VerilogInfo = "VerilogInfo",
    _make_dag_entry = "make_dag_entry",
    _make_verilog_info = "make_verilog_info",
    _verilog_library = "verilog_library",
)

VerilogInfo = _VerilogInfo
verilog_library = _verilog_library
make_dag_entry = _make_dag_entry
make_verilog_info = _make_verilog_info
