difference() {
  union() {
    pegstr();

    // 14mm standoff in front to avoid wheel
    color(c="red")
      translate(v=[-holder_offset - holder_y_size - wall_thickness * 1.5, 0, -14.7])
        cube([wall_thickness * 1, 14, 22], center=true);
  }

  // drill a hole with snug fit for the bottom half
  // 16.3 x 6.05
  color(c="green", alpha=0.5)
    translate(v=[-holder_offset - wall_thickness - holder_y_size / 2, 0, 0])
      cube([6.05, 16.3, holder_z_size * 2], center=true);
}
