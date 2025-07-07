// specify by holder x and y starting at 0
// cover walls by adding 0.5
module bin_interior(x, y) {
  translate(
    v=[
      -holder_offset - holder_y_size / 2 - wall_thickness - (holder_y_size + wall_thickness) * y,
      -(holder_x_size + wall_thickness) * holder_x_count / 2 + (x + 0.5) * (holder_x_size + wall_thickness),
      (holder_height - clip_height - wall_thickness) / 2,
    ]
  )
    cube([holder_y_size, holder_x_size, holder_height - wall_thickness], center=true);
}

difference() {
  pegstr();

  // 2 double width
  color(c="green")
    bin_interior(0.5, 1);
  color(c="red")
    bin_interior(0.5, 2);

  // 2 double depth
  color(c="magenta")
    bin_interior(3, 1.5);
  color(c="orange")
    bin_interior(2, 1.5);
}
