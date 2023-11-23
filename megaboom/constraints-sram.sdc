source util.tcl

# Set the clock name and period
set clk_period 400 

# Get the list of clock ports
set clk_ports [match_pins .*_clk]
set clk_name [lindex $clk_ports 0]

# Create the clock for each clock port
foreach clk_port_name $clk_ports {
    set clk_port [get_ports $clk_port_name]
    create_clock -name $clk_port_name -period $clk_period $clk_port
}

set clk_io_pct 0.1

# Set input and output delays for all inputs and outputs
set non_clock_inputs [lsearch -inline -all -not -exact [all_inputs] $clk_ports]
set_input_delay  [expr $clk_period * $clk_io_pct] -clock $clk_name $non_clock_inputs 
set_output_delay [expr $clk_period * $clk_io_pct] -clock $clk_name [all_outputs]
