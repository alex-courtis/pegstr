x = clip_height + holder_total_y + holder_offset;
dx = flatten_front_additional * 4;

y = max(holder_total_x, quantized_total_x) + epsilon;
dy = y - flatten_sides_additional;

z = holder_z_size_actual;
dz = z / 2 + min_z;

render()
  difference() {
    pegstr();

    color(c="yellow")
      translate(v=[dx, dy, dz])
        cube(size=[x, y, z], center=true);

    color(c="yellow")
      translate(v=[dx, -dy, dz])
        cube(size=[x, y, z], center=true);
  }
