difference() {
  difference() {
    union() {
      pegstr();

      // fill in the holes
      color(c="red") {
        for (x = [1:holder_x_count]) {
          translate(v=[-holder_x_size / 2 - wall_thickness, (x - 4) * 30, holder_z_size / 2 - hole_size - 1]) cylinder(h=holder_z_size, d1=holder_x_size + wall_thickness, d2=holder_x_size * taper_ratio + wall_thickness, center=true);
        }
      }
    }

    // exact sized holes for 30mm handles
    color(c="blue") {
      translate(v=[-holder_x_size / 2 - wall_thickness, -90, holder_z_size / 2 - hole_size - 1]) cylinder(h=holder_z_size, d1=10.75, d2=10.00, center=true);

      translate(v=[-holder_x_size / 2 - wall_thickness, -60, holder_z_size / 2 - hole_size - 1]) cylinder(h=holder_z_size, d1=11.30, d2=10.50, center=true);

      translate(v=[-holder_x_size / 2 - wall_thickness, -30, holder_z_size / 2 - hole_size - 1]) cylinder(h=holder_z_size, d1=11.80, d2=11.00, center=true);

      translate(v=[-holder_x_size / 2 - wall_thickness, +00, holder_z_size / 2 - hole_size - 1]) cylinder(h=holder_z_size, d1=13.20, d2=12.30, center=true);

      translate(v=[-holder_x_size / 2 - wall_thickness, +30, holder_z_size / 2 - hole_size - 1]) cylinder(h=holder_z_size, d1=14.30, d2=13.30, center=true);

      translate(v=[-holder_x_size / 2 - wall_thickness, +60, holder_z_size / 2 - hole_size - 1]) cylinder(h=holder_z_size, d1=17.00, d2=15.80, center=true);
    }

    // 33mm handle offset
    color(c="green") {
      translate(v=[-holder_x_size / 2 - wall_thickness, +93, holder_z_size / 2 - hole_size - 1]) cylinder(h=holder_z_size, d1=20, d2=18.6, center=true);
    }
  }
}
