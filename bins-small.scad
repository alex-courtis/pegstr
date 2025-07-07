difference() {
  pegstr();

  // 2 double width
  color(c="red")
    translate(
      v=[
        -holder_offset - holder_y_size / 2 - wall_thickness - (holder_y_size + wall_thickness) * 2,
        -(holder_x_size + wall_thickness),
        holder_height / 2 - clip_height / 2 - wall_thickness,
      ]
    )
      cube([holder_y_size, holder_x_size, holder_height], center=true);

  color(c="green")
    translate(
      v=[
        -holder_offset - holder_y_size / 2 - wall_thickness - (holder_y_size + wall_thickness) * 1,
        -(holder_x_size + wall_thickness),
        holder_height / 2 - clip_height / 2 - wall_thickness,
      ]
    )
      cube([holder_y_size, holder_x_size, holder_height], center=true);

  // 2 double depth
  color(c="magenta")
    translate(
      v=[
        -holder_offset - holder_y_size / 2 - wall_thickness - (holder_y_size + wall_thickness) * 1.5,
        (holder_x_size + wall_thickness) * 1.5,
        holder_height / 2 - clip_height / 2 - wall_thickness,
      ]
    )
      cube([holder_y_size, holder_x_size, holder_height], center=true);

  color(c="orange")
    translate(
      v=[
        -holder_offset - holder_y_size / 2 - wall_thickness - (holder_y_size + wall_thickness) * 1.5,
        (holder_x_size + wall_thickness) * 0.5,
        holder_height / 2 - clip_height / 2 - wall_thickness,
      ]
    )
      cube([holder_y_size, holder_x_size, holder_height], center=true);
}
