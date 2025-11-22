include <BOSL2/std.scad>
include <BOSL2/hinges.scad>

$fn = 200;

t_shell = 0.5;
r_shell = t_shell * 1;

t_mould_wall = 1.6;
r_mould_wall = t_mould_wall * 1;

t_mould_base = 0.8;

dy_cutoff = -120; //[-200:0.1:200]

dz_top = 50; //[0:1:200]

show_model = false;
show_top = true;
show_bottom = true;

l_hinge = 62 - 36;
d_pin = 3.75;
t_knuckle = 1.6;

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
      [30, 221 - 35.5],
      [30, 221 - 12.2],
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

// pin center is at y=0
// length x>=0
module hinge(inner, arm_height) {
  knuckle_diam = d_pin + t_knuckle * 2;
  knuckle_hinge(
    length=l_hinge,
    segs=5,
    offset=knuckle_diam / 2 + t_knuckle,
    arm_height=arm_height,
    arm_angle=90,
    clear_top=true,
    spin=180,
    pin_diam=d_pin,
    knuckle_diam=knuckle_diam,
    orient=BACK,
    anchor=BOTTOM + RIGHT,
    inner=inner,
  );
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

  translate(v=[0, 0, t_mould_base + t_shell * 2]) {

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

    // padding 6.5 to 6.5 - twice t_shell
    color(c="black") {
      translate(v=[0, 0, 6.5 - t_shell * 2]) {
        linear_extrude(h=t_shell * 2) {
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

    // major [36, 236] to minor [62, 236]
    // offset y by t_shell inner and t_mould_wall outer
    // offset z 6.5 - t_shell top * 2 
    color(c="crimson") {
      translate(
        v=[
          36,
          236 + t_shell + t_mould_wall,
          6.5 - t_shell * 2,
        ]
      ) {
        mirror(v=[0, 0, 1]) {
          hinge(inner=false, arm_height=t_mould_base);
        }
      }
    }
  }
}

module mould_bottom() {

  // base pushes everything up by t_mould_base
  color(c="blue") {
    translate(v=[0, 0, 0]) {
      linear_extrude(h=t_mould_base) {
        mould_outer();
      }
    }
  }

  // layer 0 to 2.5
  color(c="pink") {
    translate(v=[0, 0, t_mould_base + 0]) {
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
    translate(v=[0, 0, t_mould_base + 2.5]) {
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

  // major [36, 236] to minor [62, 236]
  // offset y by t_shell inner and t_mould_wall outer
  // offset z 6.5 top 
  color(c="olive") {
    translate(
      v=[
        36,
        236 + t_shell + t_mould_wall,
        t_mould_base + 2.5 + 4,
      ]
    ) {
      hinge(inner=false, arm_height=t_mould_base + 6.5 - (d_pin / 2 + t_knuckle));
    }
  }
}

render() {
  back_half(s=800) {
    translate(v=[0, dy_cutoff, 0]) {

      if (show_model) {
        translate(v=[0, 0, t_mould_base + t_shell]) {
          model3d();
        }
      }

      if (show_bottom) {
        mould_bottom();
      }

      if (show_top) {
        translate(v=[0, 0, dz_top]) {
          mould_top();
        }
      }
    }
  }
}
