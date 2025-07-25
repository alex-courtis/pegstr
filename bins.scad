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

module bin_height(row, back_h, front_h) {

  x = holder_total_y;
  y = max(holder_total_x, quantized_total_x) + epsilon;
  z = holder_z_size_actual;

  dx = -holder_offset - wall_thickness - (holder_y_size + wall_thickness) * row;

  dz = min_z - back_h - closed_bottom * wall_thickness - epsilon;

  color(c="green")
    translate(
      v=[
        dx - x / 2,
        0,
        dz + z / 2,
      ]
    )
      cube(size=[x, y, z], center=true);

  color(c="orange")
    translate(
      v=[
        dx,
        0,
        dz + holder_z_size_actual,
      ]
    )
      rotate(a=90, [1, 0, 0])
        linear_extrude(height=y, center=true)
          polygon(
            [
              [-holder_y_size - wall_thickness - epsilon, 0],
              [0, 0],
              [-holder_y_size, back_h - front_h],
              [-holder_y_size - wall_thickness - epsilon, back_h - front_h],
            ]
          );
}
