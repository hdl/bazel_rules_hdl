proc get_worst_path_length {paths} {
    set worst_path [lindex $paths 0]
    set path_length [expr {- [get_property $worst_path slack]}]

    return $path_length
}

puts stderr "OpenROAD analysis started\n"
read_verilog $::env(INPUT_NETLIST)
link_design $::env(CONSTANT_TOP)

set clock_port $::env(CONSTANT_CLOCK_PORT)
create_clock -name $clock_port [get_ports $clock_port] -period 0

set all_timing_paths [find_timing_paths -sort_by_slack]

set critical_path_length [get_worst_path_length $all_timing_paths]

puts stderr "Critical path length is $critical_path_length\n"

set reg_start $::env(CONSTANT_REG_START)
set start_nets [get_nets "$reg_start*"]
set start_instances [get_fanin -only_cells -to $start_nets]
puts stderr "start instances: [llength $start_instances]"

set reg_end $::env(CONSTANT_REG_END)
set end_nets [get_nets "$reg_end*"]
set end_instances [get_fanin -only_cells -to $end_nets]
puts stderr "end instances: [llength $end_instances]"

set reg2reg_paths [find_timing_paths -from $start_instances -to $end_instances -sort_by_slack]
set reg2reg_path_length [get_worst_path_length $reg2reg_paths]

puts stderr "Worst path from $reg_start to $reg_end has length $reg2reg_path_length\n"

puts stderr "OpenROAD analysis done\n"
