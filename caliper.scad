// 14mm standoffs to avoid wheel
color(c="red")
  translate(v=[-_holder_offset + _wall_thickness / 2, 0, -13.7])
    cube([_wall_thickness * 3, 12, 24], center=true);

