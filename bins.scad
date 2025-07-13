// specify by holder x and y starting at 0
// cover walls by adding 0.5
module bin_interior(x, y) {
  translate(
    v=[
      -holder_offset - holder_y_size / 2 - wall_thickness - (holder_y_size + wall_thickness) * y,
      -(holder_x_size + wall_thickness) * holder_x_count / 2 + (x + 0.5) * (holder_x_size + wall_thickness),
      (holder_z_size - clip_height - closed_bottom * wall_thickness + epsilon) / 2,
    ]
  )
    cube([holder_y_size, holder_x_size, holder_z_size - closed_bottom * wall_thickness + epsilon], center=true);
}

render() 
difference() {
  pegstr();

  // double width
  bin_interior(2.5, 2);
  bin_interior(4.5, 2);
  bin_interior(0.5, 3);
  bin_interior(2.5, 3);
  bin_interior(4.5, 3);
  bin_interior(6.5, 3);

  // double depth

  // 100mm bin row
  translate_100mm = [
    -holder_total_y / 2 - holder_offset - wall_thickness - (holder_y_size + wall_thickness) * 1,
    0,
    +holder_z_size / 2 - clip_height / 2 - wall_thickness * closed_bottom - 100,
  ];
  translate(translate_100mm)
    cube([holder_total_y, holder_total_x, holder_z_size], center=true);

  // 70mm bin row
  translate_70mm = [
    -holder_total_y / 2 - holder_offset - wall_thickness - (holder_y_size + wall_thickness) * 2,
    0,
    +holder_z_size / 2 - clip_height / 2 - wall_thickness * closed_bottom- 70,
  ];
  translate(translate_70mm)
    cube([holder_total_y, holder_total_x, holder_z_size], center=true);

  // 20mm bin row
  translate_20mm = [
    -holder_total_y / 2 - holder_offset - wall_thickness - (holder_y_size + wall_thickness) * 3,
    0,
    +holder_z_size / 2 - clip_height / 2 - wall_thickness * closed_bottom- 20,
  ];
  translate(translate_20mm)
    cube([holder_total_y, holder_total_x, holder_z_size], center=true);
}
