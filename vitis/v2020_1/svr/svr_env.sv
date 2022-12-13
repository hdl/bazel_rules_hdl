`ifndef SVR_ENV__SV
    `define SVR_ENV__SV
    
    class svr_env#(int DATA_WIDTH = 32) extends uvm_env;
        
        svr_master_agent#(DATA_WIDTH) m_agt;
        svr_slave_agent #(DATA_WIDTH) s_agt;
        svr_config                    cfg  ;
        
        function new (string name = "svr_env", uvm_component parent);
            super.new(name, parent);
            //`uvm_info (this.get_full_name(), "new is called", UVM_LOW)
        endfunction
        
        extern virtual function void build_phase (uvm_phase phase);
        
        `uvm_component_param_utils_begin(svr_env#(DATA_WIDTH))
        `uvm_component_utils_end
    endclass
    
    function void svr_env::build_phase (uvm_phase phase);
        super.build_phase(phase);
        `uvm_info (this.get_full_name(), "build_phase is called", UVM_LOW)
        if(!uvm_config_db #(svr_config)::get(this, "", "cfg", cfg))
            `uvm_fatal(this.get_full_name(), "svr config must be set for cfg!!!")
        if (cfg.svr_type == SVR_MASTER) begin
            m_agt = svr_master_agent#(DATA_WIDTH)::type_id::create("m_agt", this);
            //`uvm_info (this.get_full_name(), "env initialized as master", UVM_LOW)
        end else if (cfg.svr_type == SVR_SLAVE) begin
            s_agt = svr_slave_agent#(DATA_WIDTH)::type_id::create("s_agt", this);
            //`uvm_info (this.get_full_name(), "env initialized as slave", UVM_LOW)
        end else
            `uvm_fatal(this.get_full_name(), "invalid svr_config received!!!")
    endfunction
  
`endif 
