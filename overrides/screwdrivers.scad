module model() {

  color(c=screwdrivers_color) {
    translate(v=[screwdrivers_model_dx, screwdrivers_model_dy, screwdrivers_model_dz]) {
      rotate(a=180, v=[0, 0, 1]) {
        import(screwdrivers_model, center=true);
      }
    }
  }

  color(c="magenta") {
    translate(v=[0, screwdrivers_back_y / 2, screwdrivers_holes_dz]) {
      cube([screwdrivers_holes_x, screwdrivers_back_y, screwdrivers_holes_z], center=true);
    }
  }
}

module model_bounds() {
  difference() {
    cube([500, 400, 400], center=true);
    translate(v=[0, 100, 100]) {
      cube([500, 200, 200], center=true);
    }
  }
}

module combined() {
  translate(v=[0, screwdrivers_model_offset_dy, 0]) {
    scale(screwdrivers_scale)
      model();
  }

  translate(v=[-tx / 2, 0, screwdrivers_holder_dz]) {
    pegstr();
  }

  color(c="blue")
    translate(v=[0, wall_thickness / 2, (screwdrivers_holder_dz + hole_size) / 2]) {
      cube([tx, wall_thickness, screwdrivers_holder_dz + hole_size], center=true);
    }
}

module negative_z() {
  color(c="red") {
    translate(v=[0, 0, -50]) {
      cube([500, 500, 100], center=true);
    }
  }
}

render() {
  if (screwdrivers_check_model_bounds) {
    color(c="red") {
      intersection() {
        model();
        model_bounds();
      }
    }
  } else if (screwdrivers_flatten_intersection) {
    intersection() {
      combined();
      negative_z();
    }
  } else {
    difference() {
      combined();
      negative_z();
    }
  }
}
