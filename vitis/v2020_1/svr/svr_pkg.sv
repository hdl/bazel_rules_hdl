`ifndef SVR_PKG__SV
    `define SVR_PKG__SV

    package svr_pkg;
        
        import uvm_pkg::*;
        import file_agent_pkg::*;
        
        `include "uvm_macros.svh"
        
        `include "svr_object_global.svh"
        `include "svr_info.sv"
        `include "svr_config.sv"
        `include "svr_transfer.sv"
        `include "svr_base_sequence.sv"
        `include "svr_random_sequence.sv"
        `include "svr_master_sequence.sv"
        `include "svr_master_sequencer.sv"
        `include "svr_master_driver.sv"
        `include "svr_master_monitor.sv"
        `include "svr_master_agent.sv"
        `include "svr_slave_sequence.sv"
        `include "svr_slave_sequencer.sv"
        `include "svr_slave_driver.sv"
        `include "svr_slave_monitor.sv"
        `include "svr_slave_agent.sv"
        `include "svr_env.sv"
    endpackage

`endif