`ifndef MISC_INTERFACE__SV
    `define MISC_INTERFACE__SV
    `timescale 1ns/1ps
    interface misc_interface (input clock, input reset);

        logic    ap_start  ;
        logic    ap_done   ;
        logic    ap_idle   ;
        logic    ap_ready  ;
        logic    ap_continue  ;
        logic    finished;
        logic    svuvm_done;
        logic    autotbdone_vld;
        logic    autotb_done;
        logic    autotb_done_level;

        logic    svuvm_ready;
        logic    autotbready_vld;
        logic    autotb_ready;
        logic    autotb_ready_level;

        clocking pclk @(posedge clock);
            default input #0.1ns output #0.1ns; 
        endclocking

        clocking nclk @(negedge clock);
            default input #0.1ns output #0.1ns; 
        endclocking

        initial begin
            //wait(reset);
            #1;
            svuvm_done = 1'b0;
            if(autotbdone_vld) begin
                forever begin
                     @(posedge autotb_done);
                     autotb_done_level = 1;
                     wait(autotb_done==1'b0&& autotb_done_level==1'b0);
                end
            end
        end
        task  svuvm_done_gen();
            if(autotbdone_vld==1'b1) begin
                wait(autotb_done_level);
            end
            #0;
            svuvm_done = 1'b1;
            @(posedge clock);
            autotb_done_level = 1'b0;
            svuvm_done = 1'b0;
        endtask

        initial begin
            //wait(reset);
            svuvm_ready = 1'b0;
            #1;
            if(autotbready_vld) begin
                forever begin
                     @(posedge autotb_ready);
                     autotb_ready_level = 1;
                     wait(autotb_ready==1'b0&& autotb_ready_level==1'b0);
                end
            end
        end
        task  svuvm_ready_gen();
            if(autotbready_vld==1'b1) begin
                wait(autotb_ready_level);
            end
            #0;
            svuvm_ready = 1'b1;
            @(posedge clock);
            autotb_ready_level = 1'b0;
            svuvm_ready = 1'b0;
        endtask

    endinterface
`endif
