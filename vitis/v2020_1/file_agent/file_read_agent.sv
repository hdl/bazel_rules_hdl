`ifndef FILE_READ_AGENT__SV
    `define FILE_READ_AGENT__SV
    
    `define ISNAMELETTER(x)  (x>="a"&&x<="z"||x>="A"&&x<="Z"||x=="_")
    //`define ISDIGIT(x)       (x>="0"&&x<="9"||x>="a"&&x<="f"||x>="A"&&x<="F")
    `define ISDIGIT(x)       (x>="0"&&x<="9")
    `define ISSPACE(x)       (x==" "||x=="\t"||x=="\n"||x==13||x==14)
    
    class file_read_agent#(int DATA_WIDTH = 32) extends uvm_object;
        
        typedef bit [DATA_WIDTH - 1: 0] DATA_QUEUE_TYPE [$];
        typedef bit [DATA_WIDTH - 1: 0] DATA_TYPE;
        typedef enum {DEFAULTV=0, RNDMODE=1 } CFGM_e;
        
        string TV_FILE = "";
        string TV_FILE_queue [$];
        integer fp;
        integer fp_queue [$];
        integer TV_FILE_num;
        integer TV_bitwidth_queue [$];
        string token;
        string token_queue [$];
        int HEX_read;
        int DEC_read;
        
        DATA_QUEUE_TYPE TV_Queue[$];
        
        `uvm_object_param_utils_begin(file_read_agent#(DATA_WIDTH))
        `uvm_field_string(TV_FILE, UVM_DEFAULT)
        `uvm_field_int(fp, UVM_DEFAULT)
        `uvm_field_int(TV_FILE_num, UVM_DEFAULT)
        `uvm_field_int(HEX_read, UVM_DEFAULT)
        `uvm_field_int(DEC_read, UVM_DEFAULT)
        `uvm_object_utils_end
        
        function new (string name = "file_read_agent");
            super.new(name);
            TV_FILE_num = 0;
        endfunction

        extern virtual local function void    set_file_path(string path);
        extern virtual local function string  get_file_path();
        extern virtual local function void    set_file_queue(string file_queue [$]);
        extern virtual local function string  get_file_path_from_file_queue(integer i);
        extern virtual local function void    set_fp_queue(string file_queue [$]);
        extern virtual local function integer get_file_handle_from_fp_queue(integer i);
        extern virtual local function void    set_file_number(string file_queue [$]);
        extern virtual local function integer get_file_number();
        extern virtual local function void    set_bitwidth_queue(integer bitwidth_queue [$]);
        extern virtual local function integer get_bitwidth_from_queue(integer i);
        extern virtual local function void    open_read_file();
        extern virtual local function integer get_fp();
        extern virtual local function void    set_fp(integer file_handle);
        extern virtual local function void    set_token(string token_in);
        extern virtual local function string  get_token_from_queue(integer i);
        extern virtual local function int     is_read_string(string item);
        extern virtual local function void    read_token();
        extern virtual local function DATA_TYPE load_data();
        extern virtual local function string  rm_0x (); 
        extern virtual local function void    reset_HEX_read();
        extern virtual local function void    reset_DEC_read();
        extern virtual local function void    set_HEX_read();
        extern virtual local function void    set_DEC_read();
        extern virtual local function int     is_HEX_read();
        extern virtual local function int     is_DEC_read();
        extern virtual       function void    read_TVIN_file();
        extern virtual       function void    config_file(string file_queue [$], integer bitwidth_queue [$]);
        extern virtual       function int     vectfileread(input string filename, ref int data[string][$],ref string varname[$]);
        extern virtual       function int     matchstrchk(string longstr, string str);
            
    endclass
        
    function void file_read_agent::set_file_path (string path);
        TV_FILE = path;
    endfunction
        
    function string file_read_agent::get_file_path();
        return TV_FILE;
    endfunction
    
    function void file_read_agent::set_file_queue(string file_queue [$]);
        TV_FILE_queue.delete();
        TV_FILE_queue = file_queue;
    endfunction
    
    function string file_read_agent::get_file_path_from_file_queue(integer i);
        if (i >= TV_FILE_queue.size()) begin
            `uvm_fatal(this.get_full_name(), "access data out of TV_FILE_queue boundary")
        end
        
        return TV_FILE_queue[i];
    endfunction
    
    function void file_read_agent::set_file_number(string file_queue [$]);
        TV_FILE_num = file_queue.size();
    endfunction
    
    function integer file_read_agent::get_file_number();
        return TV_FILE_num;
    endfunction
    
    function void file_read_agent::set_fp_queue(string file_queue [$]);
        integer i;
        set_file_number(file_queue);
        set_file_queue(file_queue);
        
        fp_queue.delete();
        for (i = 0; i < get_file_number(); i++) begin
            set_file_path(get_file_path_from_file_queue(i));
            open_read_file();
            fp_queue.push_back(get_fp());
        end
    endfunction
    
    function integer file_read_agent::get_file_handle_from_fp_queue(integer i);
        if (i >= fp_queue.size()) begin
            `uvm_fatal(this.get_full_name(), "access data out of fp_queue boundary")
        end
        
        return fp_queue[i];
    endfunction
    
    function void    file_read_agent::set_bitwidth_queue(integer bitwidth_queue [$]);
        TV_bitwidth_queue.delete();
        TV_bitwidth_queue = bitwidth_queue;
    endfunction
    
    function integer file_read_agent::get_bitwidth_from_queue(integer i);
        if (i >= TV_bitwidth_queue.size()) begin
            `uvm_fatal(this.get_full_name(), "access data out of TV_bitwidth_queue boundary");
        end
        
        return TV_bitwidth_queue[i];
    endfunction
    
    function void file_read_agent::open_read_file();
        set_fp($fopen(TV_FILE, "r"));
        `uvm_info(this.get_full_name(), $sformatf("open file %s for read", get_file_path()), UVM_LOW)
    endfunction
    
    function integer file_read_agent::get_fp();
        return fp;
    endfunction
    
    function void file_read_agent::set_fp(integer file_handle);
        fp = file_handle;
    endfunction
    
    function void file_read_agent::set_token(string token_in);
        token = token_in;
    endfunction
    
    function string file_read_agent::get_token_from_queue(integer i);
        if (i >= token_queue.size()) begin
            `uvm_fatal(this.get_full_name(), "access data out of token_queue boundary")
        end
        
        return token_queue[i];
    endfunction
    
    function int file_read_agent::is_read_string(string item);
        integer i;
        string token_tmp;
        
        for (i = 0; i < get_file_number(); i++) begin
            token_tmp = get_token_from_queue(i);
            if (string'(token_tmp) != item)
                return 0;
        end
        
        return 1;
    endfunction
    
    function file_read_agent::DATA_TYPE file_read_agent::load_data();
        integer ret;
        integer i;
        integer j;
        integer bitwidth;
        integer LSB;
        integer MSB;
        integer shift_bit;
        string rm_0x_token;
        DATA_TYPE data_integer;
        DATA_TYPE data_integer_tmp;
        DATA_TYPE MASK;
        
        LSB = 0;
        MSB = 0;
        data_integer = {DATA_WIDTH{1'b0}};
        shift_bit = 0;
        for (i = 0; i < get_file_number(); i++) begin
            set_token(get_token_from_queue(i));
            rm_0x_token = rm_0x();
            if (is_HEX_read()) begin
                ret = $sscanf(rm_0x_token, "%x", data_integer_tmp);
            end
            else if (is_DEC_read()) begin
                ret = $sscanf(rm_0x_token, "%d", data_integer_tmp);
            end
            else begin
                `uvm_fatal(this.get_full_name(), "TVIN data format wrong");
            end

            if (ret == 0)
                `uvm_fatal(this.get_full_name(), "load data from TVIN FAIL!!!")
            bitwidth = get_bitwidth_from_queue(i);
            MSB = LSB + bitwidth - 1;
            if (MSB < LSB)
                `uvm_fatal(this.get_full_name(), "load error bitwidth!!!")
            
            MASK = {DATA_WIDTH{1'b0}};
            for (j = 0; j < bitwidth; j++) begin
                MASK[j] = 1'b1;
            end
                
            data_integer = data_integer | ((data_integer_tmp & MASK) << shift_bit);
            LSB = MSB + 1;
            shift_bit = shift_bit + bitwidth;
        end
        
        if (MSB != (DATA_WIDTH - 1))
            `uvm_fatal(this.get_full_name(), "load error bitwidth!!!")
        
        return data_integer;
    endfunction
    
    function string file_read_agent::rm_0x();
        string token_tmp = token;
        integer i;
        begin
            reset_HEX_read();
            reset_DEC_read();
            
            for (i = 0; i < token.len(); i++) begin
                if (token[i] == "x") begin
                    if (i == 0)
                        `uvm_fatal(this.get_full_name(), "TV file data format error!!!")
                    else if (token[i - 1] == "0") begin
                        break;
                    end 
                    else
                        `uvm_fatal(this.get_full_name(), "TV file data format error!!!")
                end
            end

            token_tmp[i] = "0";
            
            if (i == token.len()) begin
                set_DEC_read();
            end
            else begin
                set_HEX_read();
            end
            
            return token_tmp;
        end
    endfunction
        
    function void file_read_agent::reset_HEX_read();
        HEX_read = 0;
    endfunction
    
    function void file_read_agent::reset_DEC_read();
        DEC_read = 0;
    endfunction   

    function void file_read_agent::set_HEX_read();
        HEX_read = 1;
    endfunction
    
    function void file_read_agent::set_DEC_read();
        DEC_read = 1;
    endfunction        

    function int file_read_agent::is_HEX_read();
        return HEX_read == 1;
    endfunction
    
    function int file_read_agent::is_DEC_read();
        return DEC_read == 1;
    endfunction 
        
    function void file_read_agent::read_token();
        integer ret;
        integer i;
        integer fp_tmp;
        
        token_queue.delete(); // reset token_queue
        
        for (i = 0; i < get_file_number(); i++) begin
            ret = 0;
            fp_tmp = get_file_handle_from_fp_queue(i);
            ret = $fscanf(fp_tmp,"%s",token);
            if (ret == 0)
                `uvm_fatal(this.get_full_name(), "read token FAIL!!!")
            
            token_queue.push_back(token);
        end
    endfunction
    
    function void file_read_agent::read_TVIN_file();
        reg [DATA_WIDTH - 1: 0] data;       
        integer ret;
        DATA_QUEUE_TYPE TV;
        
        TV_Queue.delete(); // reset transaction queue before read TVIN file
        
        read_token();
        if (!is_read_string("[[[runtime]]]")) begin
            `uvm_fatal(this.get_full_name(), "ERROR: Simulation using HLS TB failed.");
        end
        
        read_token();
        while (!is_read_string("[[[/runtime]]]")) begin
            if (!is_read_string("[[transaction]]")) begin
                `uvm_fatal(this.get_full_name(), "ERROR: Simulation using HLS TB failed.");
            end
            
            read_token(); // skip transaction number
            
            read_token();
            while (!is_read_string("[[/transaction]]")) begin
    
                data = load_data();
                TV.push_back(data);
                read_token();
                `uvm_info(this.get_full_name(), $sformatf("read data: %0d", data), UVM_DEBUG)
            end
            
            TV_Queue.push_back(TV);
            
            `uvm_info(this.get_full_name(), $sformatf("transaction size: %0d", TV.size()), UVM_DEBUG)
            // clear transaction queue to recored next transaction read from TV_FILE
            TV.delete();
            
            read_token();
        end
        
        `uvm_info(this.get_full_name(), $sformatf("TV_Queue size: %0d", TV_Queue.size()), UVM_DEBUG)
        `uvm_info(this.get_full_name(), "read file done", UVM_LOW)

    endfunction
    
    function void file_read_agent::config_file(string file_queue [$], integer bitwidth_queue [$]);
        if (file_queue.size() != bitwidth_queue.size())
            `uvm_fatal(this.get_full_name(), "ERROR: size of file_queue and bitwidth_queue are different!!!");
        
        set_fp_queue(file_queue);
        set_bitwidth_queue(bitwidth_queue);
    endfunction
    
    function int file_read_agent::vectfileread(input string filename, ref int data[string][$],ref string varname[$]);
        string vectname;
        int fd;
        string line;
        bit varfound=0;
        int linenum=0;
        bit isvectfile = 0;
        bit firstelem=1;
        string field=""; 

        vectfileread = 0;
        fd = $fopen(filename, "r");
        assert(fd!=0) begin
        end else begin
            $info("file %s can't be opened, SVUVM autotb will use default configuration. I.E. interface delay will use default randomization ", filename);
            return 0;
        end

        while($fgets(line, fd)) begin
            int onedata; 
            string lineproc; 
            string value;
            int state=0;

            int i=matchstrchk(line, "//");
            if(i==-1) lineproc = line;
            if(i==0) continue;
            if(i>1) lineproc = line.substr(0, i-1);

            for(i=0; i<lineproc.len;i++) begin
                //$display("i is %0d, leftstr:%s", i, lineproc.substr(i, lineproc.len-1));
                case(state)
                    0: begin
                        if(`ISDIGIT(lineproc[i])) begin
                            value = "";
                            value = {value, string'(lineproc[i])};
                            state=11;
                        end else if( `ISNAMELETTER(lineproc[i])) begin
                            if(lineproc.substr(i,i+8)=="LEFTROUND") begin
                                assert(field !="") begin
                                    field = {field, "_mode"};
                                    data[field].push_back(int'(RNDMODE));
                                    i += 8;
                                    field="";
                                    varfound=0;
                                end else begin
                                    $error("LEFTROUND in file %s at line %d is used as configuration key word", filename, linenum);
                                    return 0;
                                end
                            end else begin
                                //$display("line409: field:%s, state:%d, %s", field, state, lineproc.substr(i, lineproc.len-1));
                                field="";
                                field={field, string'(lineproc[i])};
                                state=21;
                            end
                        end else if(`ISSPACE(lineproc[i])) begin
                            continue;
                        end else if(lineproc[i]>=33&&lineproc[i]<=126) begin
                            assert(0) begin
                            end else begin
                                $error("file %s has unknown letter at line %d", filename, linenum);
                                return 0;
                            end
                        end
                    end 11: begin //digital continue
                        if(`ISSPACE(lineproc[i])) begin
                            state=0;
                            varfound=0;
                            void'($sscanf(value, "%d", onedata));
                            vectfileread++;
                            assert(field!="") begin
                            end else begin
                                $error("file %s can't get the matched field at line %d", filename, linenum);
                                return 0;
                            end
                            //$display("line360: field:%s, state:%d, onedata:%d", field, state, onedata);
                            data[field].push_back(onedata);
                        end else if(`ISDIGIT(lineproc[i])) begin
                            value = {value, string'(lineproc[i])};
                        end else if( `ISNAMELETTER(lineproc[i])) begin
                            state = 21;
                            field = {value, string'(lineproc[i])};
                            value="";
                        end else if(lineproc[i]>=33&&lineproc[i]<=126) begin
                            assert(0) begin
                            end else begin
                                $error("file %s has unknown letter at line %d", filename, linenum);
                                return 0;
                            end
                        end
                    end 21: begin //field continue
                        if(`ISSPACE(lineproc[i])) begin
                            state=0;
                            varname.push_back(field);
                            if(varfound) begin
                                assert(0) begin
                                end else begin
                                    $error("file %s has consecutive variable label at line %d", filename, linenum);
                                    return 0;
                                end
                            end
                            varfound = 1;
                        end else if(`ISDIGIT(lineproc[i])||`ISNAMELETTER(lineproc[i])) begin
                            field={field, string'(lineproc[i])};
                            //$display("line387: field:%s, state:%d", field, state);
                        end else if(lineproc[i]>=33&&lineproc[i]<=126) begin
                            assert(0) begin
                            end else begin
                                $error("file %s has unknown letter at line %d", filename, linenum);
                                return 0;
                            end
                        end
                    end
                endcase
            end //end of one line process
        end //end of while
        $fclose(fd);
    endfunction

    function int file_read_agent::matchstrchk(string longstr, string str);
        matchstrchk = -1;
        for(int i=0; i<=longstr.len - str.len; i++)
            if(longstr.substr(i, i+str.len-1) == str) begin
                matchstrchk = i;
                break;
            end
    endfunction

`endif       
