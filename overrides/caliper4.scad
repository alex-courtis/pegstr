include <BOSL2/std.scad>
include <BOSL2/hinges.scad>

include <caliper-model.scad>

$fn = 200;

t_shell = 0.5;
r_shell = t_shell * 1;

t_mould_wall_bottom = 3.0;
r_mould_wall_bottom = t_mould_wall_bottom * 1;

t_mould_wall_top = 3.0;
r_mould_wall_top = t_mould_wall_top * 1;

t_mould_base = 0.8;

t_clip = 2.4;
y_clip = 135;
dx_clip = 0.2;
dy_clip_socket = 1.0;
r_clip_pin = 1.6;
r_clip_socket = 2.0;
dx_clip_socket = -1.05;
dx_clip_pin = -0.7;

dy_cutoff = -120; // [-200:0.1:200]

// dz_top = 50; // [0:1:200]
dz_top = 0; // [0:1:200]
dz_model = 0; // [0:1:200]

show_model = false;
show_top = true;
show_bottom = true;

d_pin = 3.80; // [1:0.01:10]
t_knuckle = 2.0; // [0.4:0.1:8]
gap_hinge = 0.2; // [0:0.01:3]
r_hinge = d_pin / 2 + t_knuckle;
seg_ratio_hinge = 1.25; // [0:0.01:10]
y_offset_hinge = 0.5;

assert(t_mould_wall_bottom <= t_mould_wall_top);

module grow(thickness, or) {
  shell2d(thickness=thickness, or=or)
    children();
  children();
}

// pin center is at y=0
// length x>=0
module hinge(inner, arm_height, length, d_offset = 0) {
  knuckle_diam = d_pin + t_knuckle * 2;
  knuckle_hinge(
    length=length,
    segs=5,
    offset=knuckle_diam / 2 + d_offset + y_offset_hinge,
    arm_height=arm_height,
    arm_angle=90,
    clear_top=true,
    spin=180,
    pin_diam=d_pin,
    knuckle_diam=knuckle_diam,
    orient=BACK,
    anchor=BOTTOM + RIGHT,
    inner=inner,
    teardrop=true,
    gap=gap_hinge,
    seg_ratio=seg_ratio_hinge,
  );
}

module mould_outer(thickness, or) {
  grow(thickness=thickness, or=or) {
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
            mould_outer(t_mould_wall_top, r_mould_wall_top);

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
            mould_outer(t_mould_wall_top, r_mould_wall_top);

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
            mould_outer(t_mould_wall_top, r_mould_wall_top);

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

    // padding 6.5 to 6.5 - once t_shell
    color(c="black") {
      translate(v=[0, 0, 6.5 - t_shell]) {
        linear_extrude(h=t_shell) {
          difference() {
            mould_outer(t_mould_wall_top, r_mould_wall_top);

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

    // // major [36, 236] to minor [62, 236]
    // // offset y by t_shell inner and t_mould_wall_top outer
    // // offset z to top of shell 6.5 - t_shell top * 2
    // color(c="crimson") {
    //   translate(
    //     v=[
    //       36,
    //       236 + t_shell + t_mould_wall_top,
    //       6.5 - t_shell * 2,
    //     ]
    //   ) {
    //     mirror(v=[0, 0, 1]) {
    //       hinge(
    //         length=62 - 36,
    //         inner=true,
    //         arm_height=9 - 6.5 + t_shell * 2 + t_mould_base - r_hinge
    //       );
    //     }
    //   }
    // }
  }

  color(c="green") {
    x = t_clip;
    z = t_mould_base * 2 + 9 + t_shell * 2;

    translate(
      v=[
        40 - x - t_mould_wall_bottom - t_shell - dx_clip,
        0,
        0,
      ]
    ) {
      cube([x, y_clip, z]);
      translate(v=[x + dx_clip_pin, 0, (t_mould_base + 6.5) / 2]) {
        rotate(a=270, v=[1, 0, 0]) {
          right_half(x=-dx_clip_pin, s=400) {
            cylinder(r=r_clip_pin, h=y_clip);
          }
        }
      }
      translate(v=[0, 0, z - t_mould_base - 2.5 - t_shell]) {
        cube([t_clip + dx_clip, y_clip, t_mould_base + 2.5 + t_shell]);
      }
    }

    translate(
      v=[
        56 + t_shell + t_mould_wall_bottom + dx_clip,
        0,
        0,
      ]
    ) {
      cube([x, y_clip, z]);
      translate(v=[-dx_clip_pin, 0, (t_mould_base + 6.5) / 2]) {
        rotate(a=270, v=[1, 0, 0]) {
          left_half(x=dx_clip_pin, s=400) {
            cylinder(r=r_clip_pin, h=y_clip);
          }
        }
      }
      translate(v=[-dx_clip, 0, z - t_mould_base - 2.5 - t_shell]) {
        cube([x + dx_clip, y_clip, t_mould_base + 2.5 + t_shell]);
      }
    }
  }
}

module mould_outer_bottom(thickness, or) {
  grow(thickness=thickness, or=or) {
    grow(thickness=t_shell, or=r_shell) {
      major2d(dxy_left=-t_shell);
      minor2d(dxy_right=t_shell);
      screw2d();
      body2d(buttons=true);
      wheel2d();
	  slide2d();
    }
  }
}

module mould_bottom() {

  difference() {
    union() {
      // base pushes everything up by t_mould_base
      color(c="blue") {
        translate(v=[0, 0, 0]) {
          linear_extrude(h=t_mould_base) {
            mould_outer_bottom(t_mould_wall_bottom, r_mould_wall_bottom);
          }
        }
      }

      // layer 0 to 2.5
      color(c="pink") {
        translate(v=[0, 0, t_mould_base + 0]) {
          linear_extrude(h=2.5) {
            difference() {
              mould_outer_bottom(t_mould_wall_bottom, r_mould_wall_bottom);

              grow(thickness=t_shell, or=0) {
                // major2d();
                minor2d(dx_left=-2 * t_shell, dxy_right=t_shell);
                screw2d();
                body2d(dy_top=2 * t_shell, buttons=true);
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
              mould_outer_bottom(t_mould_wall_bottom, r_mould_wall_bottom);

              grow(thickness=t_shell, or=0) {
                major2d(dxy_left=-t_shell);
                minor2d(dxy_right=t_shell);
                screw2d();
                body2d(buttons=true);
                wheel2d();
                slide2d();
              }
            }
          }
        }
      }

      // major [36, 236] to minor [62, 236]
      // offset y by t_shell inner and t_mould_wall_bottom outer
      // offset z to top of shell 6.5
      color(c="olive") {
        translate(
          v=[
            36,
            236 + t_shell + t_mould_wall_bottom,
            t_mould_base + 2.5 + 4,
          ]
        ) {
          hinge(
            length=62 - 36,
            inner=false,
            arm_height=t_mould_base + 6.5 - r_hinge,
            d_offset=t_mould_wall_top - t_mould_wall_bottom
          );
        }
      }
    }

    color(c="orange") {
      x = t_clip;
      z = t_mould_base * 2 + 9 + t_shell * 2;

      translate(
        v=[
          0,
          0,
          (t_mould_base + 6.5) / 2,
        ]
      ) {
        translate(
          v=[
            40 - t_mould_wall_bottom - t_shell - dx_clip + dx_clip_socket,
            0,
            0,
          ]
        ) {
          rotate(a=270, v=[1, 0, 0]) {
            cylinder(r=r_clip_socket, h=y_clip + dy_clip_socket);
          }
        }
        translate(
          v=[
            56 + t_mould_wall_bottom + t_shell + dx_clip - dx_clip_socket,
            0,
            0,
          ]
        ) {
          rotate(a=270, v=[1, 0, 0]) {
            cylinder(r=r_clip_socket, h=y_clip + dy_clip_socket);
          }
        }
      }
    }
  }
}

module clip_puller(dz) {

  // across slide 40 - 56
  x = 2 * (t_shell + t_mould_wall_top + dx_clip + t_clip + t_clip);

  translate(
    v=[
      40 - x / 2,
      -t_clip,
      dz,
    ]
  ) {
    cube(
      [
        56 - 40 + x,
        y_clip + dy_cutoff + t_clip,
        t_mould_base + t_shell,
      ]
    );
  }
}

render() {
  back_half(s=800) {
    translate(v=[0, dy_cutoff, 0]) {

      if (show_model) {
        translate(v=[0, 0, t_mould_base + t_shell + dz_model]) {
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

  // pullers
  if (show_top) {
    color(c="steelblue") {
      clip_puller(dz=9 + t_mould_base + t_shell + dz_top);
    }
  }
  if (show_bottom) {
    color(c="thistle") {
      clip_puller(dz=0);
    }
  }
}
