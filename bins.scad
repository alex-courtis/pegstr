// specify by holder x and y starting at 0
// cover walls by adding 0.5
module bin_interior(x, y) {
  translate(
    v=[
      -holder_offset - holder_y_size / 2 - wall_thickness - (holder_y_size + wall_thickness) * y,
      -(holder_x_size + wall_thickness) * holder_x_count / 2 + (x + 0.5) * (holder_x_size + wall_thickness),
      (holder_height - clip_height - closed_bottom * wall_thickness + epsilon) / 2,
    ]
  )
    cube([holder_y_size, holder_x_size, holder_height - closed_bottom * wall_thickness+ epsilon], center=true);
}

difference() {
  pegstr();

  // 3 double width
  color(c="green")
    bin_interior(1.5, 0);
  color(c="red")
    bin_interior(3.5, 0);

  // 2 double depth
  color(c="magenta")
    bin_interior(1, 1.5);
  color(c="orange")
    bin_interior(4, 1.5);

  // 3/4 height front bins
  color(c="yellow", alpha=0.5)
    translate(
      v=[
        -holder_total_y / 2 - holder_offset - wall_thickness - (holder_y_size + wall_thickness) * 3,
        0,
        +holder_height / 2 - clip_height / 2 - holder_height * 3 / 4,
      ]
    )
      cube(
        [
          holder_total_y,
          holder_total_x,
          holder_height,
        ], center=true
      );

  // half height front bins
  color(c="pink", alpha=0.5)
    translate(
      v=[
        -holder_total_y / 2 - holder_offset - wall_thickness - (holder_y_size + wall_thickness) * 4,
        0,
        +holder_height / 2 - clip_height / 2 - holder_height * 1 / 2,
      ]
    )
      cube(
        [
          holder_total_y,
          holder_total_x,
          holder_height,
        ], center=true
      );
}
