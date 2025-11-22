include <BOSL2/std.scad>

$fn = 200;

t_shell = 0.5;
r_shell = t_shell * 1;

t_mould_wall = 3;
r_mould_wall = t_mould_wall * 1;

t_mould_base = 0.8;

dy_mould = -120;

show_model = true;
show_mould = true;

module grow(thickness, or) {
  shell2d(thickness=thickness, or=or)
    children();
  children();
}

module major2d() {
  polygon(
    [
      [0 - t_shell, 222],
      [7, 229],
      [36, 236],
      [45, 236],
      [45, 221],
      [33, 221],
      [33, 208],
      [7, 215],
      [0 - t_shell, 222],
    ]
  );
}

module major3d() {
  color(c="green")
    translate(v=[0, 0, 2.5])
      linear_extrude(h=4)
        major2d();
}

module minor2d() {
  polygon(
    [
      [45, 236],
      [62, 236],
      [73, 232],
      [77 + t_shell, 228.5],
      [73, 225],
      [63, 221],
      [45, 221],
      [45, 236],
    ]
  );
}

module minor3d() {
  color(c="orange")
    linear_extrude(h=6.5)
      minor2d();
}

module screw2d() {
  polygon(
    [
      [63, 193],
      [70, 193],
      [70, 185.5],
      [63, 185.5],
      [63, 193],
    ]
  );
}

module screw3d() {
  color(c="yellowgreen")
    linear_extrude(h=8)
      screw2d();
}

module body2d() {
  polygon(
    [
      [33, 221],
      [63, 221],
      [63, 159],
      [33, 159],
      [26, 168],
      [30, 221-35.5],
      [30, 221-12.2],
      [33, 221],
    ]
  );
}

module body3d() {
  color(c="mediumvioletred")
    linear_extrude(h=17)
      body2d();
}

module wheel2d() {
  translate(v=[34, 152.5])
    circle(r=5.875);
  polygon(
    [
      [32.5, 159],
      [40.5, 159],
      [40.5, 148],
      [35, 148],
    ]
  );
}

module wheel3d() {
  color(c="yellow")
    linear_extrude(h=9)
      wheel2d();
}

module slide2d() {
  polygon(
    [
      [40, 159],
      [56, 159],
      [56, 0],
      [40, 0],
      [40, 159],
    ]
  );
}

module slide3d() {
  color(c="purple")
    translate(v=[0, 0, 2.5])
      linear_extrude(h=4)
        slide2d();
}

module model2d() {
  major2d();
  minor2d();
  screw2d();
  body2d();
  wheel2d();
  slide2d();
}

module model3d() {
  major3d();
  minor3d();
  screw3d();
  body3d();
  wheel3d();
  slide3d();
}

module mould_outer() {
  grow(thickness=t_mould_wall, or=r_mould_wall) {
    grow(thickness=t_shell, or=r_shell) {
      major2d();
      minor2d();
      screw2d();
      body2d();
      wheel2d();
      slide2d();
    }
  }
}

module mould_top() {

  translate(v=[0, 0, t_mould_base]) {

    // base 9 + t_mould_base to 9
    color(c="blue") {
      translate(v=[0, 0, 9 - 0]) {
        linear_extrude(h=t_mould_base) {
          difference() {
            mould_outer();

            grow(thickness=t_shell, or=r_shell) {
              // major2d();
              // minor2d();
              // screw2d();
              body2d();
              // wheel2d();
              // slide2d();
            }
          }
        }
      }
    }

    // layer 9 to 8
    color(c="darkorange") {
      translate(v=[0, 0, 8]) {
        linear_extrude(h=9 - 8) {
          difference() {
            mould_outer();

            grow(thickness=t_shell, or=r_shell) {
              // major2d();
              // minor2d();
              // screw2d();
              body2d();
              wheel2d();
              // slide2d();
            }
          }
        }
      }
    }

    // layer 8 to 6.5
    color(c="peru") {
      translate(v=[0, 0, 6.5]) {
        linear_extrude(h=8 - 6.5) {
          difference() {
            mould_outer();

            grow(thickness=t_shell, or=r_shell) {
              // major2d();
              // minor2d();
              screw2d();
              body2d();
              wheel2d();
              // slide2d();
            }
          }
        }
      }
    }

    // padding 6.5 to 6.5 - t_shell
    color(c="maroon") {
      translate(v=[0, 0, 6.5 - t_shell]) {
        linear_extrude(h=t_shell) {
          difference() {
            mould_outer();

            grow(thickness=t_shell, or=r_shell) {
              major2d();
              minor2d();
              screw2d();
              body2d();
              wheel2d();
              slide2d();
            }
          }
        }
      }
    }
  }
}

module mould_bottom() {

  translate(v=[0, 0, t_mould_base]) {

    // base -t_mould_base to 0
    color(c="blue") {
      translate(v=[0, 0, -t_mould_base]) {
        linear_extrude(h=t_mould_base) {
          mould_outer();
        }
      }
    }

    // layer 0 to 2.5
    color(c="pink") {
      translate(v=[0, 0, 0]) {
        linear_extrude(h=2.5) {
          difference() {
            mould_outer();

            grow(thickness=t_shell, or=r_shell) {
              // major2d();
              minor2d();
              screw2d();
              body2d();
              wheel2d();
              // slide2d();
            }
          }
        }
      }
    }

    // layer 2.5 to 6.5 
    color(c="brown") {
      translate(v=[0, 0, 2.5]) {
        linear_extrude(h=6.5 - 2.5) {
          difference() {
            mould_outer();

            grow(thickness=t_shell, or=r_shell) {
              major2d();
              minor2d();
              screw2d();
              body2d();
              wheel2d();
              slide2d();
            }
          }
        }
      }
    }
  }
}

render() {
  // top
  translate(v=[-10, 0, 0]) {
    back_half(s=800) {
      translate(v=[0, dy_mould, 0]) {
        rotate(a=180, v=[0, 1, 0]) {
          union() {
            if (show_model) {
              translate(v=[0, 0, t_mould_base]) {
                model3d();
              }
            }

            if (show_mould) {
              mould_top();
            }
          }
        }
      }
    }
  }

  // bottom
  translate(v=[10, 0, 0]) {
    back_half(s=800) {
      translate(v=[0, dy_mould, 0]) {
        union() {
          if (show_model) {
            translate(v=[0, 0, t_mould_base]) {
              model3d();
            }
          }

          if (show_mould) {
            mould_bottom();
          }
        }
      }
    }
  }
}
