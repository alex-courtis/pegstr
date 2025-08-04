top_mult = 1.030;
bottom_mult = 1.01;

bits = [
  7,
  10.7,
  7,
];

difference() {
  union() {
    pegstr();

    row = 0;
    for (col = [0:1:holder_x_count - 1]) {

      d1 = bits[col] * top_mult;
      d2 = bits[col] * bottom_mult;
      echo(d1=d1, d2=d2);

      translate(
        v=[
          -holder_offset - holder_y_size / 2 - wall_thickness - row * (holder_y_size + wall_thickness),
          (col + 0.5 - holder_x_count / 2) * (holder_x_size + wall_thickness + holder_x_spacing),
          holder_z_size / 2 - clip_height / 2,
        ]
      ) {
        union() {
          difference() {

            // fill in the holes
            color(c="orange")
              cylinder(h=holder_z_size, d=holder_x_size + wall_thickness, center=true, $fn=holder_sides);

            // specific sized hole
            #color(c="red")
              translate(v=[0, 0, -wall_thickness * closed_bottom])
                cylinder(h=holder_z_size, d1=d1, d2=d2, center=true, $fn=holder_sides * 2);
          }
        }
      }
    }
  }
}
