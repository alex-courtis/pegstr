
check_bounds = false;

module v6_large() {

  // experiment
  model_dx = 0;
  model_dy = 16.550;
  model_dz = 18.730;

  holes_x = 132.95;
  holes_z = 6.05;
  holes_dz = 8.0;

  back_y = 2;

  translate(v=[model_dx, model_dy, model_dz]) {
    rotate(a=180, v=[0, 0, 1]) {
      color(c="lightblue") {
        import("/lord/prn/FrankLumien/screwdriver-holder-pegboard-or-wall-mounted/Screwdriver holder v6 large nologo.stl", center=true);
      }
    }
  }

  color(c="green") {
    translate(v=[0, back_y / 2, holes_dz]) {
      cube([holes_x, back_y, holes_z], center=true);
    }
  }
}

module out_of_bounds() {
  difference() {
    cube([500, 400, 400], center=true);
    translate(v=[0, 100, 100]) {
      cube([500, 200, 200], center=true);
    }
  }
}

render() {
  if (check_bounds) {
    // nothing should be rendered
    color(c="red") {
      intersection() {
        v6_large();
        out_of_bounds();
      }
    }
  } else {
    difference() {
      union() {
        scale(1)
          v6_large();

        translate(v=[-tx / 2, 0, 0]) {
          pegstr();
        }
      }
      cube([500, 500, flatten_bottom_dz], center=true);
    }
  }
}
