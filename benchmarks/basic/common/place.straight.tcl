set db [ord::get_db_block]

set core_area [$db getCoreArea]
set core_area_x0 [$core_area xMin]
set core_area_x1 [$core_area xMax]
set core_area_width [expr {$core_area_x1 - $core_area_x0}]

set core_area_y0 [$core_area yMin]
set core_area_y1 [$core_area yMax]
set core_area_height [expr {$core_area_y1 - $core_area_y0}]

puts "\nCoreArea (($core_area_x0,$core_area_y0) ($core_area_x1,$core_area_y1)) ($core_area_width x $core_area_height)\n"

set dff0 [$db findInst "mod.a0_\$_DFF_P__Q"]
set dff0_bbox [$dff0 getBBox]
set dff0_width [$dff0_bbox getDX]
set dff0_height [$dff0_bbox getDY]

puts "\nDFF size is $dff0_width x $dff0_height\n"

puts "\nUsing 'straight' placement"
puts " * Inputs  A on left edge"
puts " * Inputs  B on left edge"
puts " * Outputs X on right edge"

set pad 0

set y0 [expr {$core_area_y0 + $pad}]

set x0 [expr {$core_area_x0 + $pad}]
set xn [expr {$core_area_x1 - $dff0_width - $pad}]

set flops 8

set y_ff_offset [expr {$dff0_height * 2}]
set y_group_size [expr {$core_area_height / ($flops + 2)}]

set y [expr {$y0 + $y_group_size / 2 + $y_group_size}]

for {set i 0} {$i < $flops} {incr i} {
  set a_dff_name "mod.a$i\_\$_DFF_P__Q"
  set a_dff [$db findInst $a_dff_name]
  $a_dff setLocation $x0 $y
  $a_dff setPlacementStatus "PLACED"
  puts "Placed $a_dff_name @ ($x0 $y)"

  set b_dff_name "mod.b$i\_\$_DFF_P__Q"
  set b_dff [$db findInst $b_dff_name]
  set y_b [expr {$y + $y_ff_offset}]
  $b_dff setLocation $x0 $y_b
  $b_dff setPlacementStatus "PLACED"
  puts "Placed $b_dff_name @ ($x0 $y_b)"

  set x_dff_name "x$i\_\$_DFF_P__Q"
  set x_dff [$db findInst $x_dff_name]
  $x_dff setLocation $xn $y
  $x_dff setPlacementStatus "PLACED"
  puts "Placed $x_dff_name @ ($xn $y)"

  set y [expr {$y + $y_group_size}]
  puts ""
}
