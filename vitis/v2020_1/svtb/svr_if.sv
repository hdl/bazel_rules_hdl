`ifndef SVR_IF__SV
    `define SVR_IF__SV

    interface svr_if#(int DATA_WIDTH = 32)(input clk, input rst);
        
        logic [DATA_WIDTH -1: 0] data ;
        logic                    valid;
        logic                    ready;

        property noxwhenh(logic x, logic y);
            disable iff(!rst)
                @(posedge clk)
                (x&y)===1'b0 | (x===1'b1 && (y===1'b0|y==='h1)) | (y==='b1 && (x===1'b0|x==='b1));
        endproperty
            
        property nodatax(logic x, logic y, logic [DATA_WIDTH - 1: 0] data);
            disable iff(!rst)
                @(posedge clk)
                (x&y)===1'b0 | ((x === 1'b1) && (y === 1'b1) && (|data === 1'b0) | (|data === 1'b1)) | (x === 1'bx) | (y === 1'bx);
        endproperty    
            
        validh_readxy: assert property(noxwhenh(valid, ready))
            else $error("invalid X state when valid/ready is asserted time:%0t  valid:%0d, ready:%0d", $time, valid, ready);
        
        validh_data: assert property(nodatax(valid, ready, data))
            else $error("data is in X state when valid and ready are asserted time:%0t", $time);
        
        stable_when_valid: assert property(
                    @(posedge clk) disable iff(!rst)
                    ready===1'b0 && $rose(valid) | ($fell(ready) && valid===1'b1) | ($fell(ready) && $rose(valid)) |=> 
                    ($stable(data) [*0:$] ##1 ready===1'b1 & $stable(data)) or (ready===1'b1 & $stable(data))
                )
            else $error("data is not stable when valid is asserted time:%0t", $time);
    endinterface

`endif
