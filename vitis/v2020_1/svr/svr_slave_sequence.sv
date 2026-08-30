`ifndef SVR_SLAVE_SEQUENCE__SV
	`define SVR_SLAVE_SEQUENCE__SV
    
	class svr_slave_sequence#(int DATA_WIDTH = 32) extends svr_base_sequence#(DATA_WIDTH);
        
		svr_transfer#(DATA_WIDTH) svr_trans;
        
        `uvm_object_param_utils_begin (svr_slave_sequence#(DATA_WIDTH))
        `uvm_object_utils_end
      
		function new (string name = "svr_slave_sequence");
			super.new(name);
			`uvm_info(this.get_full_name(), "new is called", UVM_LOW)
		endfunction
 
		virtual task body();
            svr_info info;
            uvm_object data;
			`uvm_info(this.get_full_name(), "body is called", UVM_LOW)

			fork 
                begin
                    forever begin
                        int delay;
                        `uvm_info(this.get_full_name(), "receive data", UVM_DEBUG)
                        `uvm_create(svr_trans);

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
                        `uvm_info(this.get_full_name(), {"send trans:", svr_trans.sprint}, UVM_MEDIUM)
                        `uvm_send(svr_trans);
                        //if (is_event_FINAL_AP_DONE()) begin
                        //    `uvm_info (this.get_full_name(), "received final AP_DONE", UVM_LOW)
                        //    break;
                        //end
                    end
                    
			     end
                 forever begin
                     svr_evt_ap_done.wait_trigger_data(data);
                     $cast(info, data);
                     if(info.dutevt == FINAL_AP_DONE) break;
                 end
             
                 //begin
                 //    forever begin
                 //        parse_trigger();
                 //    end
                 //end
            join_any
            disable fork;
		endtask
            
	endclass
    
`endif
