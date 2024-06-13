`ifndef SVR_MONITOR__SV
    `define SVR_MONITOR__SV
    
    class svr_monitor#(int DATA_WIDTH = 32) extends uvm_monitor;
        
        virtual svr_if#(DATA_WIDTH) vif;
        uvm_analysis_port #(svr_transfer#(DATA_WIDTH)) item_collect_port;
        
        svr_config cfg;
        
        covergroup master_v2rdelay;
            option.per_instance = 1;
            v2rdelay: coverpoint delay
            {
                bins min = {-1};
                bins zero = {0};
                bins norm[] = {[1: 20]};
            }
        endgroup
        
        covergroup slave_v2rdelay;
            option.per_instance = 1;
            v2rdelay: coverpoint delay
            {
                bins norm[] = {[-20: -1]};
                bins zero = {0};
                bins max = {1};
            }
        endgroup
        
        int delay;        
        int state;
        
        `uvm_component_param_utils_begin(svr_monitor#(DATA_WIDTH));
        `uvm_component_utils_end
        
        function new(string name = "svr_monitor", uvm_component parent = null);
            super.new(name, parent);
            `uvm_info(this.get_full_name(), "new is called", UVM_LOW)
            master_v2rdelay = new;
            master_v2rdelay.option.name = this.get_full_name();
            slave_v2rdelay = new;
        endfunction
        
        virtual function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            `uvm_info(this.get_full_name(), "build_phase is called", UVM_LOW);        
            
            item_collect_port = new("item_collect_port", this);
            
            if(!uvm_config_db#(virtual svr_if#(DATA_WIDTH))::get(this, "", "vif", vif))
                `uvm_fatal(this.get_full_name(), "virtual interface must be set for vif!!!") 
            
            if(!uvm_config_db #(svr_config)::get(this, "", "cfg", cfg))
                `uvm_fatal(this.get_full_name(), "svr config must be set for cfg!!!") 
            if (cfg.svr_type == SVR_MASTER) begin
                
                `uvm_info (this.get_full_name(), "monitor initialized to analyze master valid to ready delay", UVM_LOW)
            end
            else if (cfg.svr_type == SVR_SLAVE) begin
                
                `uvm_info (this.get_full_name(), "monitor initialized to analyze slave valid to ready delay", UVM_LOW)
            end
            else
                `uvm_fatal(this.get_full_name(), "invalid svr_config received!!!")
        endfunction
        
        extern task run_phase(uvm_phase phase);
        extern task collect_one_pkt(svr_transfer#(DATA_WIDTH) tr);
        extern task calculate_delay();
    endclass
       
    task svr_monitor::run_phase(uvm_phase phase);
        svr_transfer#(DATA_WIDTH) tr;
        fork
            while (1) begin
                tr = new("tr");
                collect_one_pkt(tr);
                item_collect_port.write(tr);
            end
            
            calculate_delay();
        join
    endtask
    
    task svr_monitor::collect_one_pkt(svr_transfer#(DATA_WIDTH) tr);
        forever begin
            @(posedge vif.clk);
            if ((vif.valid == 1'b1) && (vif.ready == 1'b1)) begin
                tr.data = vif.data;
                break;
            end
        end
        
        `uvm_info(this.get_full_name(), "collected one pkt", UVM_DEBUG);
    endtask
    
    task svr_monitor::calculate_delay();
        parameter STATE_IDLE       = 1;
        parameter STATE_WAIT_READY = 2;
        parameter STATE_WAIT_VALID = 4;
        parameter STATE_DUMP_DELAY = 8;
        
        delay = 0;
        state = STATE_IDLE;
        
        fork
            forever begin
                @(posedge vif.clk);
                case (state)
                    STATE_IDLE : begin
                        if ((vif.valid == 1'b1) && (vif.ready == 1'b1)) begin
                            state <= STATE_DUMP_DELAY;
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
                            state <= STATE_DUMP_DELAY;
                        end
                        else begin
                            state <= STATE_WAIT_READY;
                        end
                    end
                    
                    STATE_WAIT_VALID : begin
                        if (vif.valid == 1'b1) begin
                            state <= STATE_DUMP_DELAY;
                        end
                        else begin
                            state <= STATE_WAIT_VALID;
                        end
                    end
                    
                    STATE_DUMP_DELAY : begin
                        if ((vif.valid == 1'b1) && (vif.ready == 1'b1)) begin
                            state <= STATE_DUMP_DELAY;
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
                
                `uvm_info(this.get_full_name(), $sformatf("state: %0d", state), UVM_DEBUG);
            end
            
            forever begin
                @(posedge vif.clk);
                if (state == STATE_WAIT_READY) begin
                    // state is WAIT_READY, means valid is captured, delay is a negative value
                    delay <= delay - 1;
                end
                else if (state == STATE_WAIT_VALID) begin
                    // state is WAIT_VALID, means ready is captured, delay is a positive value
                    delay <= delay + 1;
                end
                else if (state == STATE_DUMP_DELAY) begin
                    delay <= 0;
                end
                else if (state == STATE_IDLE) begin
                    delay <= 0;
                end
                else begin
                    delay <= delay;
                end
                `uvm_info(this.get_full_name(), $sformatf("delay: %0d", delay), UVM_DEBUG);
            end
            
            forever begin
                @(posedge vif.clk);
                if (state == STATE_DUMP_DELAY) begin
                    `uvm_info(this.get_full_name(), $sformatf("calculate delay: %0d", delay), UVM_HIGH);
          
                    if (cfg.svr_type == SVR_MASTER) begin
                        master_v2rdelay.sample;
                        `uvm_info (this.get_full_name(), "monitor initialized to analyze master valid to ready delay", UVM_LOW)
                    end
                    else if (cfg.svr_type == SVR_SLAVE) begin
                        slave_v2rdelay.sample;
                        `uvm_info (this.get_full_name(), "monitor initialized to analyze slave valid to ready delay", UVM_LOW)
                    end
                    else
                        `uvm_fatal(this.get_full_name(), "invalid svr_config received!!!")
                end
            end
        join
  
    endtask

`endif
