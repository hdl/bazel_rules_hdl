`ifndef SVR_MASTER_DRIVER__SV
    `define SVR_MASTER_DRIVER__SV    
    class svr_master_driver#(int DATA_WIDTH = 32) extends uvm_driver#(svr_transfer#(DATA_WIDTH));
        virtual svr_if#(DATA_WIDTH) vif;
        svr_config cfg;
        
        `uvm_component_param_utils_begin (svr_master_driver#(DATA_WIDTH))
        `uvm_component_utils_end
        function new (string name = "svr_master_driver", uvm_component parent = null);
            super.new (name, parent);
            `uvm_info (this.get_full_name(), "new is called", UVM_LOW)
        endfunction
        
        extern virtual task run_phase (uvm_phase phase);
        extern virtual function void build_phase (uvm_phase phase);
        extern virtual task get_and_drive(svr_transfer#(DATA_WIDTH) tr);
    endclass
    
    function void svr_master_driver::build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(this.get_full_name(), "build_phase is called", UVM_LOW);
        if(!uvm_config_db #(virtual svr_if#(DATA_WIDTH))::get(this, "", "vif", vif))
            `uvm_fatal(this.get_full_name(), "virtual interface must be set for vif!!!")
        
        if(!uvm_config_db #(svr_config)::get(this, "", "cfg", cfg))
            `uvm_fatal(this.get_full_name(), "svr config must be set for cfg!!!") 

    endfunction
    
    task svr_master_driver::run_phase (uvm_phase phase);
        `uvm_info (this.get_full_name(), "run_phase is called", UVM_LOW)
                
        vif.data <= {DATA_WIDTH{1'b0}};
        vif.valid <= 1'b0;
        if (cfg.prt_type == AP_VLD || cfg.prt_type==AP_NONE) begin
            vif.ready <= 1'b0;
        end
        
        //reduce one clock waiting after reset is de-asserted
        //better timing for ap_none input
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
    
    task svr_master_driver::get_and_drive(svr_transfer#(DATA_WIDTH) tr);   

        `uvm_info (this.get_full_name(), "begin to drive data", UVM_FULL)
        `uvm_info (this.get_full_name(), $sformatf("receive data: %0d, delay: %0d", tr.data, tr.delay), UVM_HIGH)
        
        //reduce one clock waiting after reset is de-asserted
        //better timing for ap_none input
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
        
        if ((cfg.prt_type == AXIS) || (cfg.prt_type == AP_FIFO) || (cfg.prt_type == AP_HS)) begin
            if (tr.delay > 0) begin
                repeat (tr.delay) @(posedge vif.clk);
            end
        end
        else if ((cfg.prt_type == AP_VLD )|| (cfg.prt_type == AP_NONE)) begin
            // AP_VLD and AP_NONE no delay
            vif.ready = 1'b1;
        end
        else if (cfg.prt_type == AP_ACK) begin
            // AP_ACK no delay
        end
        else
            `uvm_fatal(this.get_full_name(), "invalid svr_config received, unsupported port protocol!!!")
 
        #0;
        vif.data = tr.data;
        vif.valid = 1'b1;
        
        `uvm_info (this.get_full_name(), "set vif.valid = 1", UVM_HIGH)
        forever begin
            @(posedge vif.clk);
            if ((vif.ready == 1) && (vif.valid == 1)) begin
                vif.valid <= 1'b0;             
                if (cfg.prt_type == AP_VLD || cfg.prt_type==AP_NONE) begin
                    vif.ready = 1'b0;
                end
                `uvm_info (this.get_full_name(), "get vif.ready = 1", UVM_HIGH)
                `uvm_info (this.get_full_name(), "set vif.valid = 0", UVM_HIGH)
                break;
            end
        end

        `uvm_info (this.get_full_name(), "data is drived", UVM_FULL)
        
    endtask
    
`endif
