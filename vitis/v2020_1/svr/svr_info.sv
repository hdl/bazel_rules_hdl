`ifndef SVR_INFO__SV
    `define SVR_INFO__SV
    
    class svr_info extends uvm_object;
        hs_event dutevt;
        int trans_size;
        
        `uvm_object_utils_begin(svr_info)
        `uvm_field_enum(hs_event, dutevt, UVM_DEFAULT);
        `uvm_field_int(trans_size, UVM_DEFAULT);
        `uvm_object_utils_end
        
        function new (string name = "svr_info");
            super.new(name);
        endfunction
    endclass
    
`endif