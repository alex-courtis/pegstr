difference() {
  difference() {
    union() {
      rotate([180, 0, 0])
        pegstr();

      // fill in the holes
      color(c="red") {
        for (x = [1:holder_x_count]) {
          translate(v=[-holder_x_size / 2 - wall_thickness, (x - 4) * 30, holder_height / 2 - hole_size - 1]) cylinder(h=holder_height, d1=holder_x_size + wall_thickness, d2=holder_x_size * taper_ratio + wall_thickness, center=true);
        }
      }
    }

    color(c="blue") {
      translate(v=[-holder_x_size / 2 - wall_thickness, -90, holder_height / 2 - hole_size - 1]) cylinder(h=holder_height, d1=10.75, d2=10.00, center=true);

      translate(v=[-holder_x_size / 2 - wall_thickness, -60, holder_height / 2 - hole_size - 1]) cylinder(h=holder_height, d1=11.30, d2=10.50, center=true);

      translate(v=[-holder_x_size / 2 - wall_thickness, -30, holder_height / 2 - hole_size - 1]) cylinder(h=holder_height, d1=11.80, d2=11.00, center=true);

      translate(v=[-holder_x_size / 2 - wall_thickness, +00, holder_height / 2 - hole_size - 1]) cylinder(h=holder_height, d1=13.20, d2=12.30, center=true);

      translate(v=[-holder_x_size / 2 - wall_thickness, +30, holder_height / 2 - hole_size - 1]) cylinder(h=holder_height, d1=14.30, d2=13.30, center=true);

      translate(v=[-holder_x_size / 2 - wall_thickness, +60, holder_height / 2 - hole_size - 1]) cylinder(h=holder_height, d1=17.00, d2=15.80, center=true);
    }

    color(c="green") {
      translate(v=[-holder_x_size / 2 - wall_thickness, +93, holder_height / 2 - hole_size - 1]) cylinder(h=holder_height, d1=20, d2=18.6, center=true);
    }
  }

  // slice the top off
  color(c="black") {
    translate(v=[-holder_y_size / 2, 0, -7.1])
      cube(size=[holder_y_size * 2, (holder_x_count + 1) * holder_x_size, 1], center=true);
  }
}
