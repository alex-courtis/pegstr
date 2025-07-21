// specify by holder x and y starting at 0
// cover walls by adding 0.5
module bin_interior(x, y) {
  color(c="red")
    translate(
      v=[
        -holder_offset - holder_y_size / 2 - wall_thickness - (holder_y_size + wall_thickness) * y,
        -(holder_x_size + wall_thickness) * holder_x_count / 2 + (x + 0.5) * (holder_x_size + wall_thickness),
        (holder_z_size_actual - clip_height - closed_bottom * wall_thickness + epsilon) / 2,
      ]
    )
      cube(
        [
          holder_y_size,
          holder_x_size,
          holder_z_size_actual - closed_bottom * wall_thickness + epsilon,
        ],
        center=true
      );
}

module bin_height(y, h) {
  color(c="green")
    translate(
      [
        -holder_total_y / 2 - holder_offset - wall_thickness - (holder_y_size + wall_thickness) * y,
        0,
        +holder_z_size / 2 - clip_height / 2 - wall_thickness * closed_bottom - h,
      ]
    )
      cube(
        [
          holder_total_y,
          holder_total_x,
          holder_z_size,
        ],
        center=true
      );
}
