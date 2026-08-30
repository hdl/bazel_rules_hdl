`ifndef FILE_WRITE_AGENT__SV
    `define FILE_WRITE_AGENT__SV
    
    class file_write_agent#(int DATA_WIDTH = 32) extends uvm_object;
        
        typedef logic [DATA_WIDTH - 1: 0] DATA_TYPE;
        
        string TV_FILE = "";
        integer fp;
        integer file_open;
        integer write_file_done;
        integer write_section_done;
        integer TRANSACTION_NUM;
        integer transaction_num_idx;
        integer TRANSACTION_DEPTH;
        integer TRANSACTION_DEPTH_queue [$];
        integer TRANSACTION_DEPTH_queue_for_depth_check [$];
        integer transaction_depth_idx;
        integer ap_done_num_idx;
        
        `uvm_object_param_utils_begin(file_write_agent#(DATA_WIDTH))
        `uvm_field_string(TV_FILE, UVM_DEFAULT)
        `uvm_field_int(fp, UVM_DEFAULT)
        `uvm_field_int(file_open, UVM_DEFAULT)
        `uvm_field_int(write_file_done, UVM_DEFAULT)
        `uvm_field_int(write_section_done, UVM_DEFAULT)
        `uvm_field_int(TRANSACTION_NUM, UVM_DEFAULT)
        `uvm_field_int(transaction_num_idx, UVM_DEFAULT)
        `uvm_field_int(TRANSACTION_DEPTH, UVM_DEFAULT)
        `uvm_field_queue_int(TRANSACTION_DEPTH_queue, UVM_DEFAULT)
        `uvm_field_queue_int(TRANSACTION_DEPTH_queue_for_depth_check, UVM_DEFAULT)
        `uvm_field_int(transaction_depth_idx, UVM_DEFAULT)
        `uvm_field_int(ap_done_num_idx, UVM_DEFAULT)
        `uvm_object_utils_end
        
        function new (string name = "file_write_agent");
            super.new(name);
            file_open = 0;
            write_file_done = 0;
            write_section_done = 0;
            TRANSACTION_NUM = 0;
            transaction_num_idx = 0;
            TRANSACTION_DEPTH = 0;
            transaction_depth_idx = 0;
            ap_done_num_idx = 0;
        endfunction
        
        extern virtual local function void   set_file_open();
        extern virtual local function void   set_file_close();
        extern virtual local function void   increase_transaction_num_idx();
        extern virtual local function void   increase_transaction_depth_idx();
        extern virtual local function void   increase_ap_done_num_idx();
        extern virtual local function int    get_transaction_num_idx();
        extern virtual local function int    get_ap_done_num_idx();
        
        extern virtual local function void   set_file_path (string path);
        extern virtual local function string get_file_path();
        extern virtual local function void   open_write_file();
        extern virtual local function void   close_file();
        extern virtual local function int    is_file_open();
        extern virtual local function void   reset_write_file_done();
        extern virtual local function void   set_write_file_done();
        extern virtual       function int    is_write_file_done();
        extern virtual       task            wait_write_file_done();
        extern virtual local function void   reset_write_section_done();
        extern virtual local function void   set_write_section_done();
        extern virtual       function int    is_write_section_done();        
        
        extern virtual local function void   set_transaction_depth(integer depth); 
        extern virtual local function int    get_transaction_depth();
        extern virtual local function void   set_transaction_num(integer num);
        extern virtual local function void   set_transaction_depth_queue(integer trans_depth_queue [$]);
        extern virtual local function void   reset_transaction_depth_queue();
        extern virtual local function void   set_transaction_depth_queue_for_depth_check(integer trans_depth_queue [$]);
        extern virtual local function void   reset_transaction_depth_queue_for_depth_check();
        extern virtual       function int    get_next_transaction_depth();
        extern virtual local function void   reset_transaction_depth();
        extern virtual local function void   reset_transaction_num();
        extern virtual local function void   reset_transaction_depth_idx();
        extern virtual local function void   reset_transaction_num_idx();
        extern virtual local function void   reset_ap_done_num_idx();
        extern virtual local function int    is_reset_transaction_depth_idx();
        extern virtual local function int    is_reach_transaction_depth();
        extern virtual local function int    is_exceed_transaction_depth();
        extern virtual local function int    is_reach_transaction_num();
        extern virtual local function int    retrieve_transaction_depth_from_queue();
        
        extern virtual local function void   dump_start_runtime();
        extern virtual local function void   dump_stop_runtime();
        extern virtual local function void   dump_start_transaction();
        extern virtual local function void   dump_stop_transaction();
        extern virtual local function void   dump_data(DATA_TYPE data);
        extern virtual local function void   dump_dummy_bits();
        extern virtual local function void   prepare_next_transaction_write();
        extern virtual       function void   config_file(string path, integer trans_depth_queue [$]);
        extern virtual       function void   write_TVOUT_data(DATA_TYPE data);
        extern virtual       function void   receive_ap_done();
    endclass
    
    function void file_write_agent::close_file();
        $fclose(fp);
        set_file_close();
        set_write_file_done();
    endfunction
    
    function int file_write_agent::is_file_open();
        return file_open;
    endfunction
    
    function void file_write_agent::reset_write_file_done();
        write_file_done = 0;
    endfunction

    function void file_write_agent::set_write_file_done();
        write_file_done = 1;
    endfunction

    function int file_write_agent::is_write_file_done();
        return write_file_done == 1;
    endfunction  

    function void file_write_agent::reset_write_section_done();
        write_section_done = 0;
    endfunction
    
    task file_write_agent::wait_write_file_done();
        wait (write_file_done == 1);
    endtask      
    
    function void file_write_agent::set_write_section_done();
        write_section_done = 1;
    endfunction

    function int file_write_agent::is_write_section_done();
        return write_section_done == 1;
    endfunction    
    
    function void file_write_agent::set_file_open();
        file_open = 1;
    endfunction
    
    function void file_write_agent::set_file_close();
        file_open = 0;
    endfunction
    
    function void file_write_agent::increase_transaction_num_idx();
        transaction_num_idx++;
    endfunction
    
    function void file_write_agent::increase_ap_done_num_idx();
        ap_done_num_idx++;
    endfunction   

    function int  file_write_agent::get_transaction_num_idx();
        return transaction_num_idx;
    endfunction

    function int  file_write_agent::get_ap_done_num_idx();
         return ap_done_num_idx;
    endfunction
    
    function void file_write_agent::increase_transaction_depth_idx();
        transaction_depth_idx++;
    endfunction
    
    function void file_write_agent::set_file_path(string path);
        TV_FILE = path;
    endfunction
    
    function string file_write_agent::get_file_path();
        return TV_FILE;
    endfunction
    
    function void   file_write_agent::set_transaction_depth(integer depth);
        TRANSACTION_DEPTH = depth;
    endfunction
    
    function int    file_write_agent::get_transaction_depth();
        return TRANSACTION_DEPTH;
    endfunction
    
    function void   file_write_agent::set_transaction_num(integer num);
        TRANSACTION_NUM = num;
    endfunction

    function void   file_write_agent::set_transaction_depth_queue(integer trans_depth_queue [$]);
        reset_transaction_depth_queue();
        TRANSACTION_DEPTH_queue = trans_depth_queue;
    endfunction
    
    function void   file_write_agent::reset_transaction_depth_queue();
        TRANSACTION_DEPTH_queue.delete();
    endfunction
    
    function void   file_write_agent::set_transaction_depth_queue_for_depth_check(integer trans_depth_queue [$]);
        reset_transaction_depth_queue_for_depth_check();
        TRANSACTION_DEPTH_queue_for_depth_check = trans_depth_queue;
    endfunction
    
    function void   file_write_agent::reset_transaction_depth_queue_for_depth_check();
        TRANSACTION_DEPTH_queue_for_depth_check.delete();
    endfunction
    
    function int    file_write_agent::get_next_transaction_depth();
        return TRANSACTION_DEPTH_queue_for_depth_check.pop_front();
    endfunction
    
    function void   file_write_agent::reset_transaction_depth();
        TRANSACTION_DEPTH = 0;
    endfunction
    
    function void   file_write_agent::reset_transaction_num();
        TRANSACTION_NUM = 0;
    endfunction
    
    function void   file_write_agent::reset_transaction_depth_idx();
        transaction_depth_idx = 0;
    endfunction
    
    function void   file_write_agent::reset_transaction_num_idx();
        transaction_num_idx = 0;
    endfunction
    
    function void   file_write_agent::reset_ap_done_num_idx();
        ap_done_num_idx = 0;
    endfunction
    
    function int    file_write_agent::is_reset_transaction_depth_idx();
        return transaction_depth_idx == 0;
    endfunction
    
    function int    file_write_agent::is_reach_transaction_depth();
        return transaction_depth_idx == TRANSACTION_DEPTH;
    endfunction
    
    function int    file_write_agent::is_exceed_transaction_depth();
        return transaction_depth_idx > TRANSACTION_DEPTH;
    endfunction
    
    function int    file_write_agent::is_reach_transaction_num();
        return transaction_num_idx == TRANSACTION_NUM;
    endfunction    
    
    function int    file_write_agent::retrieve_transaction_depth_from_queue();
        return TRANSACTION_DEPTH_queue.pop_front();
    endfunction
    
    function void file_write_agent::open_write_file();
        fp = $fopen(TV_FILE, "w");
        set_file_open();
        reset_write_file_done();
        `uvm_info(this.get_full_name(), $sformatf("open file %s for write", get_file_path()), UVM_LOW);
    endfunction
        
    function void file_write_agent::dump_start_runtime();
        $fdisplay(fp,"[[[runtime]]]");
    endfunction
    
    function void file_write_agent::dump_stop_runtime();
        $fdisplay(fp,"[[[/runtime]]]");
    endfunction
    
    function void file_write_agent::dump_start_transaction();
        $fdisplay(fp,"[[transaction]] %d", transaction_num_idx);
    endfunction
    
    function void file_write_agent::dump_stop_transaction();
        $fdisplay(fp,"[[/transaction]]");
    endfunction
    
    function void file_write_agent::dump_data(DATA_TYPE data);
        $fdisplay(fp,"0x%x",data);
    endfunction
    
    function void file_write_agent::dump_dummy_bits();
        $fdisplay(fp, "0x0");
    endfunction
    
    function void file_write_agent::config_file(string path, integer trans_depth_queue [$]);
        int i;
        set_file_path(path);
        set_transaction_num(trans_depth_queue.size());
        set_transaction_depth_queue(trans_depth_queue);
        set_transaction_depth_queue_for_depth_check(trans_depth_queue);
        reset_transaction_depth();
        reset_transaction_depth_idx();
        reset_transaction_num_idx();
        reset_ap_done_num_idx();
        open_write_file();
        dump_start_runtime();
        `uvm_info(this.get_full_name(), $sformatf("config write file with transaction number %0d", trans_depth_queue.size()), UVM_LOW)
        prepare_next_transaction_write();
    endfunction
    
    function void file_write_agent::prepare_next_transaction_write();
        if (is_reach_transaction_num()) begin
            dump_stop_runtime();
            close_file();
            return;
        end
        
        set_transaction_depth(retrieve_transaction_depth_from_queue());
        dump_start_transaction();
        reset_transaction_depth_idx();
        
        while (get_transaction_depth() == 0) begin
            dump_stop_transaction();
            reset_transaction_depth_idx();
            increase_transaction_num_idx();
            set_write_section_done();
            
            if (is_reach_transaction_num()) begin
                dump_stop_runtime();
                close_file();
                return;
            end
            
            set_transaction_depth(retrieve_transaction_depth_from_queue());
            dump_start_transaction();
        end
    endfunction
    

    function void file_write_agent::write_TVOUT_data(DATA_TYPE data);
        if (is_file_open()) begin
            dump_data(data);
            increase_transaction_depth_idx();
            reset_write_section_done();
            if (is_reach_transaction_depth()) begin
                dump_stop_transaction();
                increase_transaction_num_idx();
                set_write_section_done();
                prepare_next_transaction_write();
            end
        end
    endfunction
        
    function void file_write_agent::receive_ap_done();
        if (is_file_open()) begin
            increase_ap_done_num_idx();
            if (get_ap_done_num_idx() > get_transaction_num_idx()) begin              
                dump_stop_transaction();
                increase_transaction_num_idx();
                set_write_section_done();
                prepare_next_transaction_write();
            end
        end
    endfunction
    
`endif