puts "hello.tcl"
puts [concat "output file name: " $::env(OUTPUT_HELLO)]
set output_file [open $::env(OUTPUT_HELLO) "w"]
puts $output_file "Hello, $::env(CONSTANT_NAME), Bazel and OpenROAD!"
close $output_file
