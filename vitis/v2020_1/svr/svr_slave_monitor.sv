`ifndef SVR_SLAVE_MONITOR__SV
    `define SVR_SLAVE_MONITOR__SV
    
    class svr_slave_monitor#(int DATA_WIDTH = 32) extends uvm_monitor;
        
        virtual svr_if#(DATA_WIDTH) vif;
        uvm_analysis_port #(svr_transfer#(DATA_WIDTH)) item_collect_port;
        
        svr_config cfg;
        
        int delay;        
        int state;
        int state_d1;
        
        covergroup slave_v2rdelay;
            option.per_instance = 1;
            v2rdelay: coverpoint delay
            {
                bins norm[] = {[-20: -1]};
                bins zero = {0};
                bins max[] = {[1: 200]};
            }
        endgroup
        
        `uvm_component_param_utils_begin(svr_slave_monitor#(DATA_WIDTH));
        `uvm_component_utils_end
        
        function new(string name = "svr_slave_monitor", uvm_component parent = null);
            super.new(name, parent);
           `uvm_info(this.get_full_name(), "new is called", UVM_LOW)
            slave_v2rdelay = new;
            slave_v2rdelay.option.name = this.get_full_name();
        endfunction
        
        virtual function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            `uvm_info(this.get_full_name(), "build_phase is called", UVM_LOW);        
            
            item_collect_port = new("item_collect_port", this);
            
            if(!uvm_config_db#(virtual svr_if#(DATA_WIDTH))::get(this, "", "vif", vif))
                `uvm_fatal(this.get_full_name(), "virtual interface must be set for vif!!!") 
            
            if(!uvm_config_db #(svr_config)::get(this, "", "cfg", cfg))
                `uvm_fatal(this.get_full_name(), "svr config must be set for cfg!!!") 
            if (cfg.svr_type != SVR_SLAVE)
                `uvm_fatal(this.get_full_name(), "invalid svr_config received!!!")
                
        endfunction
        
        extern task run_phase(uvm_phase phase);
        extern task collect_one_pkt(svr_transfer#(DATA_WIDTH) tr);
        extern task calculate_delay();
    endclass
       
    task svr_slave_monitor::run_phase(uvm_phase phase);
        svr_transfer#(DATA_WIDTH) tr;
        `uvm_info(this.get_full_name(), "run_phase is called", UVM_LOW);        
        fork
            while (1) begin
                tr = new("tr");
                collect_one_pkt(tr);
                item_collect_port.write(tr);
            end
            
            calculate_delay();
        join
    endtask
    
    task svr_slave_monitor::collect_one_pkt(svr_transfer#(DATA_WIDTH) tr);
        forever begin
            @(posedge vif.clk);
            if ((vif.valid == 1'b1) && (vif.ready == 1'b1)) begin
                tr.data = vif.data;
                break;
            end
        end
        
        `uvm_info(this.get_full_name(), "collected one pkt", UVM_DEBUG);
    endtask
    
    task svr_slave_monitor::calculate_delay();
        parameter STATE_IDLE         = 1;
        parameter STATE_WAIT_READY   = 2;
        parameter STATE_WAIT_VALID   = 4;
        parameter STATE_COLLECT_DATA = 8;
        
        delay = 0;
        state = STATE_IDLE;
        state_d1 = STATE_IDLE;
        
		if (cfg.reset_level == RESET_LEVEL_LOW) begin
            while (!vif.rst)
                @(posedge vif.clk);
        end
        else if (cfg.reset_level == RESET_LEVEL_HIGH) begin
            while (vif.rst)
                    @(posedge vif.clk);
        end 
        else begin
            `uvm_fatal(this.get_full_name(), "invalid svr_config received, unsupported reset level!!!")
        end 
        
        fork
            forever begin
                @(posedge vif.clk);
                case (state)
                    STATE_IDLE : begin
                        if ((vif.valid == 1'b1) && (vif.ready == 1'b1)) begin
                            state <= STATE_COLLECT_DATA;
                        end
                        else if (vif.valid == 1'b1) begin
                            state <= STATE_WAIT_READY;
                        end
                        else if (vif.ready == 1'b1) begin
                            state <= STATE_WAIT_VALID;
                        end
                        else begin
                            state <= STATE_IDLE;
                        end                        
                    end
                    
                    STATE_WAIT_READY : begin
                        if (vif.ready == 1'b1) begin
                            state <= STATE_COLLECT_DATA;
                        end
                        else begin
                            state <= STATE_WAIT_READY;
                        end
                    end
                    
                    STATE_WAIT_VALID : begin
                        if (vif.valid == 1'b1) begin
                            state <= STATE_COLLECT_DATA;
                        end
                        else begin
                            state <= STATE_WAIT_VALID;
                        end
                    end
                    
                    STATE_COLLECT_DATA : begin
                        if ((vif.valid == 1'b1) && (vif.ready == 1'b1)) begin
                            state <= STATE_COLLECT_DATA;
                        end
                        else if (vif.valid == 1'b1) begin
                            state <= STATE_WAIT_READY;
                        end
                        else if (vif.ready == 1'b1) begin
                            state <= STATE_WAIT_VALID;
                        end
                        else begin
                            state <= STATE_IDLE;
                        end
                    end
                    
                    default: begin
                        state <= STATE_IDLE;
                    end
                endcase
                
                state_d1 <= state;
                
                `uvm_info(this.get_full_name(), $sformatf("state: %0d, state_d1: %0d", state, state_d1), UVM_DEBUG);
            end
            
            forever begin
                @(posedge vif.clk);
                if (state == STATE_COLLECT_DATA) begin
                    delay <= 0;
                end
                else begin
                    delay <= delay + 1;
                end
                
                `uvm_info(this.get_full_name(), $sformatf("delay: %0d", delay), UVM_DEBUG);
            end
            
            forever begin
                @(posedge vif.clk);
                if (((state == STATE_WAIT_VALID)   && (state_d1 == STATE_IDLE))         ||
                    ((state == STATE_COLLECT_DATA) && (state_d1 == STATE_WAIT_READY))   ||
                    ((state == STATE_COLLECT_DATA) && (state_d1 == STATE_COLLECT_DATA)) ||
                    ((state == STATE_WAIT_VALID)   && (state_d1 == STATE_COLLECT_DATA)) ||
                    ((state == STATE_COLLECT_DATA) && (state_d1 == STATE_IDLE))) begin
                    `uvm_info(this.get_full_name(), $sformatf("calculate delay: %0d, state: %0d, state_d1: %0d", delay, state, state_d1), UVM_DEBUG);
                    slave_v2rdelay.sample;
                end
            end
        join
  
    endtask

`endif
