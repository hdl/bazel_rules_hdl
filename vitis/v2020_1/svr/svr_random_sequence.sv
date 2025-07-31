`ifndef SVR_RANDOM_SEQUENCE__SV
    `define SVR_RANDOM_SEQUENCE__SV
    
    class svr_random_sequence#(int DATA_WIDTH = 32) extends svr_base_sequence#(DATA_WIDTH);
        
        svr_transfer#(DATA_WIDTH) svr_trans;
        
        DATA_TYPE data;
        
        `uvm_object_param_utils_begin (svr_random_sequence#(DATA_WIDTH))
        `uvm_object_utils_end
        
        function new (string name = "svr_random_sequence");
            super.new(name);
            `uvm_info(this.get_full_name(), "new is called", UVM_LOW)
        endfunction
        
        virtual task body();           
            int delay;
            `uvm_info(this.get_full_name(), "begin to send random data", UVM_LOW)
            
            while (1) begin
                `uvm_create(svr_trans);
                void'(svr_trans.randomize());
                if(isusr_delay==NO_DELAY) svr_trans.delay = 0;
                else if(usr_delay.size==0) begin
                    void'(std::randomize(delay) with {
                                delay dist {1:=4, 0:=4, ii:=1, latency:=1, [0:latency]:/5};
                                delay inside {[0:latency]};
                                                     });
                    svr_trans.delay = delay;
                end else begin
                    svr_trans.delay = usr_delay.pop_front();
                    if(isusr_delay==LEFT_ROUND_DELAY) usr_delay.push_back(svr_trans.delay);
                end
                `uvm_send(svr_trans);
            end
        endtask
        
    endclass
     
`endif
