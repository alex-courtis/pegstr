difference() {
  rotate([180, 0, 0])
    pegstr();

  // taper the sides to make insertion a bit easier
  color(c="green")
    translate(v=[-holder_offset - wall_thickness, 0, -hole_size])
      rotate(a=35, v=[0, -1, 0])
        cube([wall_thickness, holder_x_size, holder_y_size], center=true);
}

// 14mm standoff in front to avoid wheel
color(c="red")
  translate(v=[-holder_offset - holder_y_size - wall_thickness * 1.5, 0, -13.7])
    cube([wall_thickness * 1, 14, 24], center=true);
