`ifndef SVR_SLAVE_DRIVER__SV
    `define SVR_SLAVE_DRIVER__SV    
    class svr_slave_driver#(int DATA_WIDTH = 32) extends uvm_driver#(svr_transfer#(DATA_WIDTH));
        virtual svr_if#(DATA_WIDTH) vif;
        svr_config cfg;
        
        `uvm_component_param_utils_begin (svr_slave_driver#(DATA_WIDTH))
        `uvm_component_utils_end
        function new (string name = "svr_slave_driver", uvm_component parent = null);
            super.new (name, parent);
            `uvm_info (this.get_full_name(), "new is called", UVM_LOW)
        endfunction
        
        extern virtual task run_phase (uvm_phase phase);
        extern virtual function void build_phase (uvm_phase phase);
        extern virtual task get_and_drive(svr_transfer#(DATA_WIDTH) tr);
    endclass
    
    function void svr_slave_driver::build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(this.get_full_name(), "build_phase is called", UVM_LOW);
        if(!uvm_config_db #(virtual svr_if#(DATA_WIDTH))::get(this, "", "vif", vif))
            `uvm_fatal(this.get_full_name(), "virtual interface must be set for vif!!!")
        
        if(!uvm_config_db #(svr_config)::get(this, "", "cfg", cfg))
            `uvm_fatal(this.get_full_name(), "svr config must be set for cfg!!!")
    endfunction
    
    task svr_slave_driver::run_phase (uvm_phase phase);
        `uvm_info (this.get_full_name(), "run_phase is called", UVM_LOW)
                
        if ((cfg.prt_type == AP_NONE) || (cfg.prt_type == AP_ACK)) begin //for ap_none/ap_ack, don't know when data is valid or ready
                                                                                                     //use AESL_done as valid and ready
            wait(0);
        end

        vif.ready <= 1'b0;
        
        //reduce one clock waiting after reset is de-asserted
        //better timing for ap_none output
        if (cfg.reset_level == RESET_LEVEL_LOW) begin
            wait(vif.rst===1'b1);
            //while (!vif.rst)
            //    @(posedge vif.clk);
        end
        else if (cfg.reset_level == RESET_LEVEL_HIGH) begin
            wait(vif.rst===1'b0);
            //while (vif.rst)
            //        @(posedge vif.clk);
        end 
        else begin
            `uvm_fatal(this.get_full_name(), "invalid svr_config received, unsupported reset level!!!")
        end
        
        while (1) begin
            seq_item_port.get_next_item(req);
            get_and_drive(req);
            seq_item_port.item_done();
        end
    endtask
    
    task svr_slave_driver::get_and_drive(svr_transfer#(DATA_WIDTH) tr);  
        
        `uvm_info (this.get_full_name(), "begin to drive data", UVM_FULL)
        `uvm_info (this.get_full_name(), $sformatf("receive delay: %0d", tr.delay), UVM_HIGH)
        
        //reduce one clock waiting after reset is de-asserted
        //better timing for ap_none output
        if (cfg.reset_level == RESET_LEVEL_LOW) begin
            wait(vif.rst===1'b1);
            //while (!vif.rst)
            //    @(posedge vif.clk);
        end
        else if (cfg.reset_level == RESET_LEVEL_HIGH) begin
            wait(vif.rst===1'b0);
            //while (vif.rst)
            //        @(posedge vif.clk);
        end 
        else begin
            `uvm_fatal(this.get_full_name(), "invalid svr_config received, unsupported reset level!!!")
        end       
        
        if ((cfg.prt_type == AXIS) || (cfg.prt_type == AP_HS) || (cfg.prt_type == AP_FIFO)) begin
            if (tr.delay > 0) begin
                repeat (tr.delay) @(posedge vif.clk);
            end
        end 
        else if (cfg.prt_type == AP_VLD) begin
        end
        else
            `uvm_fatal(this.get_full_name(), "invalid svr_config received, unsupported port protocol!!!")
        
        #0
        vif.ready = 1'b1;
        `uvm_info (this.get_full_name(), "set vif.ready = 1", UVM_HIGH)
        
        
        forever begin
            @(posedge vif.clk);
            if ((vif.valid == 1) && (vif.ready == 1'b1)) begin
                vif.ready <= 1'b0;
                `uvm_info (this.get_full_name(), "set vif.ready = 0", UVM_HIGH)
                break;
            end
        end
        `uvm_info (this.get_full_name(), "data is drived", UVM_FULL)
    endtask
    
`endif
