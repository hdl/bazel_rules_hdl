proc get_worst_path_length {paths} {
    set max_length 0
    foreach path $paths {
        set path_length [expr {- [get_property $path slack]}]
        if {[expr $path_length > $max_length]} {
            set max_length $path_length
        }
    }
    return $max_length
}

proc get_register_instances {nets} {
    set instances [list]
    foreach net $nets {
        set net_name [get_full_name $net]
        # puts stderr "Net $net_name"
        if { [string match "*comb*" $net_name] } {
            # puts stderr "Skipping combinational net $net_name"
        } else {
            set net_instances [get_fanin -only_cells -to $net]
            foreach net_instance $net_instances {
                # puts stderr "Instance [get_full_name $net_instance]"
                lappend instances $net_instance
            }
        }
    }
    return $instances
}

puts stderr "OpenROAD analysis started\n"
read_verilog $::env(INPUT_NETLIST)
link_design $::env(CONSTANT_TOP)

set clock_port $::env(CONSTANT_CLOCK_PORT)
create_clock -name $clock_port [get_ports $clock_port] -period 0

set all_timing_paths [find_timing_paths -sort_by_slack]

set critical_path_length [get_worst_path_length $all_timing_paths]

puts stderr "Critical path length is $critical_path_length\n"

set start_nets [get_nets "p0_*"]
# puts stderr "Pipeline stage 0: [llength $start_nets] nets"
set start_instances [get_register_instances $start_nets]
# puts stderr "Pipeline stage 0: [llength $start_instances] instances\n"

set end_nets [get_nets "p1_*"]
# puts stderr "Pipeline stage 1: [llength $end_nets] nets"
set end_instances [get_register_instances $end_nets]
# puts stderr "Pipeline stage 1: [llength $end_instances] instances"

set stage 1
while {[llength $start_instances] > 0} {
    set stage_pattern [join [list "p$stage" "_*[*]"] ""]
    # puts stderr "Stage pattern $stage_pattern"
    set end_nets [get_nets -quiet "$stage_pattern"]
    set end_instances [get_register_instances $end_nets]

    if {[llength $end_instances] > 0} {
            if { $stage > 1 } {
                # puts stderr "Pipeline stage $stage [llength $end_nets] nets"
                # puts stderr "Pipeline stage $stage [llength $end_instances] instances"
            }
        set stage_paths [find_timing_paths -from $start_instances -to $end_instances -sort_by_slack -endpoint_count 101 -group_count 101]

        if {[llength $stage_paths] > 0} {

            if {[llength $stage_paths] <= 100} {
                puts stderr "[llength $stage_paths] timing paths found in stage $stage"
            } else {
                puts stderr "Over 100 timing paths found in stage $stage"
            }

            set stage_path_length [get_worst_path_length $stage_paths]
            puts stderr "Worst path in pipeline stage $stage has length $stage_path_length\n"
        } else {
            puts stderr "No timing paths found in pipeline stage $stage ??\n"
        }
    }

    set stage [expr {$stage + 1}]
    set start_instances $end_instances
}

puts stderr "OpenROAD analysis done\n"
