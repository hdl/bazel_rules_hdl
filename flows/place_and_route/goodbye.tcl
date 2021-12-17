set hello_file [open $::env(INPUT_HELLO) "r"]
set hello_txt [read $hello_file]
close $hello_file
puts $hello_txt

set goodbye_file [open $::env(OUTPUT_GOODBYE) "w"]
puts $goodbye_file $hello_txt
puts $goodbye_file "Goodbye, cruel world!"
close $goodbye_file
