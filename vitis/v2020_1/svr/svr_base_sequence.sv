`ifndef SVR_BASE_SEQUENCE__SV
    `define SVR_BASE_SEQUENCE__SV
    
    class svr_base_sequence#(int DATA_WIDTH = 32) extends uvm_sequence #(svr_transfer#(DATA_WIDTH));

        uvm_event svr_evt_ap_done;
        uvm_event svr_evt_ap_ready;
        uvm_event svr_evt_ap_start;
        uvm_event svr_evt_finish;
        string received_event;
        svr_info info;
        file_read_agent#(DATA_WIDTH) file_rd;
        int ii;
        int latency;
        virtual interface misc_interface misc_if;
        int usr_delay[$];
        svr_delay_enum isusr_delay = NO_DELAY;


        
        typedef bit [DATA_WIDTH - 1: 0] DATA_QUEUE_TYPE [$];
        typedef bit [DATA_WIDTH - 1: 0] DATA_TYPE;
        
        protected DATA_QUEUE_TYPE TV_Queue[$];
        protected DATA_QUEUE_TYPE TV;
        
        `uvm_object_param_utils_begin (svr_base_sequence#(DATA_WIDTH))
        `uvm_object_utils_end
        
        function new (string name = "svr_base_sequence");
            super.new(name);
            svr_evt_ap_done  = new("svr_evt_ap_done");
            svr_evt_ap_ready = new("svr_evt_ap_ready");
            svr_evt_ap_start = new("svr_evt_ap_start");
            svr_evt_finish   = new("svr_evt_finish");
            file_rd = new("file_rd");
            received_event = "";
            `uvm_info(this.get_full_name(), "new is called", UVM_LOW)
        endfunction
        
        extern virtual protected task parse_trigger();
        
        extern virtual protected function void      read_file();
        extern virtual protected function int       get_TestVector_num();
        extern virtual protected function int       get_TestVector_size();
        extern virtual local function void          push_TestVector(DATA_QUEUE_TYPE TV);
        extern virtual protected function void      pop_TestVector();
        extern virtual local function void          push_data(DATA_TYPE data);
        extern virtual protected function DATA_TYPE pop_data();
        
        extern virtual protected function int       is_event_AP_START();
        extern virtual protected function int       is_event_AP_READY();
        extern virtual protected function int       is_event_AP_DONE();
        extern virtual protected function int       is_event_FINAL_AP_DONE();
        extern virtual protected function int       is_event_FINISH();

    endclass
    
    task svr_base_sequence::parse_trigger();
        //uvm_object data;
        //svr_evt.wait_trigger_data(data);
        //
        //$cast(info, data);
        //assert($cast(info, data)) else
        //    `uvm_error(this.get_full_name(), "Dynamic cast failed!")
        //if (info.dutevt == AP_START)
        //    received_event = "AP_START";
        //else if (info.dutevt == AP_READY)
        //    received_event = "AP_READY";
        //else if (info.dutevt == AP_DONE)
        //    received_event = "AP_DONE";
        //else if (info.dutevt == FINAL_AP_DONE)
        //    received_event = "FINAL_AP_DONE";
        //else if (info.dutevt == FINISH)
        //    received_event = "FINISH";
        //else
        //    `uvm_fatal(this.get_full_name(), "unkown event received");
        //
        //`uvm_info(this.get_full_name(), $sformatf("receive event: %s", received_event), UVM_FULL)
    endtask            
   
    
    function int svr_base_sequence::get_TestVector_num();
        return TV_Queue.size();
    endfunction
    
    function int svr_base_sequence::get_TestVector_size();
        return TV.size();
    endfunction
    
    function void svr_base_sequence::push_TestVector(DATA_QUEUE_TYPE TV);
        TV_Queue.push_back(TV);
    endfunction
    
    function void svr_base_sequence::pop_TestVector();
        TV = TV_Queue.pop_front();
    endfunction
    
    function void svr_base_sequence::push_data(DATA_TYPE data);
        TV.push_back(data);
    endfunction
    
    function svr_base_sequence::DATA_TYPE svr_base_sequence::pop_data();
        return TV.pop_front();
    endfunction
                
    function void svr_base_sequence::read_file();
        file_rd.read_TVIN_file();
        TV_Queue = file_rd.TV_Queue;
    endfunction
    
    function int svr_base_sequence::is_event_AP_START();
        return received_event == "AP_START";
    endfunction
    
    function int svr_base_sequence::is_event_AP_READY();
        return received_event == "AP_READY";
    endfunction
    
    function int svr_base_sequence::is_event_AP_DONE();
        return received_event == "AP_DONE";
    endfunction
    
    function int svr_base_sequence::is_event_FINAL_AP_DONE();
        return received_event == "FINAL_AP_DONE";
    endfunction
    
    function int svr_base_sequence::is_event_FINISH();
        return received_event == "FINISH";
    endfunction
    
`endif
        
