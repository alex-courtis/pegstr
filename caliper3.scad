difference() {
  pegstr();

  color(c="purple") {

    // based on flatten

    x = clip_height + holder_total_y + holder_offset;
    dx = -x / 2 - holder_offset - wall_thickness + 3; // wheel back beyond ruler

    y = holder_x_size;
    dy = -holder_x_size + 1.6; // wheel over ruler, corner radius will do

    z = 14; // top down to bottom of wheel
    dz = z / 2 + min_z;

    translate(v=[dx, dy, dz])
      cube([x, y, z], center=true);
  }
}
