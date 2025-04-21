`ifndef SVR_MASTER_AGENT__SV
	`define SVR_MASTER_AGENT__SV
    
	class svr_master_agent#(int DATA_WIDTH = 32) extends uvm_agent;
		svr_master_sequencer#(DATA_WIDTH) sqr;
		svr_master_driver#(DATA_WIDTH)    drv;
		svr_master_monitor#(DATA_WIDTH)   mon;
		uvm_analysis_port #(svr_transfer#(DATA_WIDTH)) item_collect_port;
        
        svr_config cfg  ;
        
		function new (string name, uvm_component parent);
			super.new(name, parent);
			//`uvm_info(this.get_full_name(), "new is called", UVM_LOW)
		endfunction
        
		extern virtual function void build_phase (uvm_phase phase);
		extern virtual function void connect_phase (uvm_phase phase);
        
		`uvm_component_param_utils_begin(svr_master_agent#(DATA_WIDTH))
        `uvm_component_utils_end
	endclass
    
	function void svr_master_agent::build_phase(uvm_phase phase);
		super.build_phase(phase);
		//`uvm_info(this.get_full_name(), "build_phase is called", UVM_LOW);
        
        if(!uvm_config_db #(svr_config)::get(this, "", "cfg", cfg))
            `uvm_fatal(this.get_full_name(), "svr config must be set for cfg!!!")
        
		if (cfg.is_active == SVR_ACTIVE) begin
			sqr = svr_master_sequencer#(DATA_WIDTH)::type_id::create("sqr", this);
			drv = svr_master_driver#(DATA_WIDTH)::type_id::create("drv", this);
		end
        
		mon = svr_master_monitor#(DATA_WIDTH)::type_id::create("mon", this);
	endfunction
    
	function void svr_master_agent::connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		if (cfg.is_active == SVR_ACTIVE) begin
			drv.seq_item_port.connect(sqr.seq_item_export);
		end
        item_collect_port = mon.item_collect_port;
		//`uvm_info(this.get_full_name(), "connect_phase is called", UVM_LOW);
	endfunction
    
`endif
 
