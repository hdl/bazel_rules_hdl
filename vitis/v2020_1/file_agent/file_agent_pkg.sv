`ifndef FILE_AGENT_PKG__SV
    `define FILE_AGENT_PKG__SV

    package file_agent_pkg;
        
        import uvm_pkg::*;
        `include "uvm_macros.svh"
        `include "file_read_agent.sv"
        `include "file_write_agent.sv"
    endpackage

`endif