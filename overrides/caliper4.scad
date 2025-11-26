include <BOSL2/std.scad>
include <BOSL2/hinges.scad>

include <caliper-model.scad>

$fn = 200;

t_shell = 0.35; // [0:0.01:5]
// t_shell = 0.45; // for pegstr
r_shell = t_shell * 1;

t_mould_wall_bottom = 3.5; // [0:0.05:10]
r_mould_wall_bottom = t_mould_wall_bottom * 1;

t_mould_wall_top = 3.5; // [0:0.05:10]
r_mould_wall_top = t_mould_wall_top * 1;

t_mould_base = 0.8; // [0.2:0.1:10]
// t_mould_base = 2.0; // for pegstr

t_snap = 2.4; // [0.2:0.1:10]
d_snap = t_mould_base + 2.5 + 4;
// increase to leave a gap between wall and snap
dx_snap = 0.12; // [0:0.01:10]

dy_cutoff = -120; // [-200:0.1:200]

dz_top = 40; // [0:1:200]
dz_model = 20; // [0:1:200]
dz_pegs = -20; // [0:1:-100]

show_model = true;
show_top = true;
show_bottom = true;
show_snap = true;
show_hinge = true;

// open via pegstr.scad, select the caliper4 profile, comment out $fn and manually adjust the caliper4 params
show_pegstr = false;

d_pin = 3.80; // [1:0.01:10]
t_knuckle = 2.0; // [0.4:0.1:8]
gap_hinge = 0.2; // [0:0.01:3]
r_hinge = d_pin / 2 + t_knuckle;
seg_ratio_hinge = 1.25; // [0:0.01:10]
dy_hinge = 0.5; // [0:0.1:10]

module grow(thickness, or) {
  shell2d(thickness=thickness, or=or)
    children();
  children();
}

// pin center is at y=0
// length x>=0
module hinge(inner, arm_height, length, dy) {
  knuckle_diam = d_pin + t_knuckle * 2;
  knuckle_hinge(
    length=length,
    segs=5,
    offset=knuckle_diam / 2 + dy,
    arm_height=arm_height + knuckle_diam / 2,
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
    clip=knuckle_diam / 2 + arm_height,
  );
}

module snap(t, socket) {
  x = 56 - 40 + t_shell * 2 + t_mould_wall_bottom * 2 + (socket ? dx_snap * 2 : 0);
  dz = t_mould_base + 2.5 + 4 + 2 * t_shell + 2.5 + t_mould_base;
  translate(
    v=[
      40 + (56 - 40) / 2,
      -dy_cutoff,
      socket ? dz : 0,
    ]
  ) {
    difference() {
      if (socket) {
        rotate(a=180, v=[1, 0, 0]) {
          snap_socket(
            thick=t,
            foldangle=180,
            snapdiam=d_snap,
            snaplen=x,
            layerheight=0,
            hingegap=0,
            anchor=BACK,
            orient=UP,
          );
        }
      } else {
        snap_lock(
          thick=t,
          foldangle=180,
          snapdiam=d_snap,
          snaplen=x,
          layerheight=0,
          hingegap=0,
          anchor=FRONT,
          orient=UP,
        );
      }
      translate(v=[0, 0, (socket ? -d_snap : 0)]) {
        translate(v=[x / 2 + t_snap, 0, (socket ? -t : 0)]) {
          cube(size=[x - t_snap, d_snap, t + d_snap]);
        }
        translate(v=[-x / 2 + t_snap, 0, (socket ? -t : 0)]) {
          cube(size=[x - t_snap * 2, d_snap, t + d_snap]);
        }
        translate(v=[-x * 3 / 2, 0, (socket ? -t : 0)]) {
          cube(size=[x - t_snap, d_snap, t + d_snap]);
        }
      }
    }
  }
}

module pegstr_back(dz) {
  translate(v=[31.5, 236 - tz + t_shell + t_mould_wall_bottom, -wall_thickness + dz]) {
    rotate(a=-90, v=[1, 0, 0]) {
      mirror(v=[0, 1, 0]) {
        pegstr();
      }
    }
  }
}

module pegstr_holes() {
  z = wall_thickness - dz_pegstr + t_mould_base + t_shell;

  // xy very approximate
  translate(v=[0, 0, -z + t_mould_base + t_shell]) {
    translate(v=[49, 164, 0]) {
      cylinder(r=1.5, h=z);
    }
    translate(v=[40, (233 + 164) / 2, 0]) {
      cylinder(r=1.5, h=z);
    }
    translate(v=[57, (233 + 164) / 2, 0]) {
      cylinder(r=1.5, h=z);
    }
    translate(v=[49, 233, 0]) {
      cylinder(r=1.5, h=z);
    }
  }
}

module mould_outer(thickness, or) {
  grow(thickness=thickness, or=or) {
    grow(thickness=t_shell, or=t_shell) {
      screw2d();
      body2d(buttons=true);
      wheel2d();
      slide2d();
    }
    grow(thickness=t_shell, or=0) {
      major2d(dxy_left=-t_shell);
      minor2d(dxy_right=t_shell);
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
              body2d(buttons=true, dy_bottom=-2 * t_shell);
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
              body2d(buttons=true, dy_bottom=-2 * t_shell);
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
              body2d(buttons=true, dy_bottom=-2 * t_shell);
              wheel2d();
              // slide2d();
            }
          }
        }
      }
    }

    // padding 6.5 to 6.5 - double t_shell
    color(c="limegreen") {
      translate(v=[0, 0, 6.5 - 2 * t_shell]) {
        linear_extrude(h=t_shell * 2) {
          difference() {
            mould_outer(t_mould_wall_top, r_mould_wall_top);

            grow(thickness=t_shell, or=r_shell) {
              screw2d();
              body2d(buttons=true, dy_bottom=-2 * t_shell);
              wheel2d();
              slide2d();
            }
            grow(thickness=t_shell, or=0) {
              major2d();
              minor2d(dx_left=-2 * t_shell, dxy_right=t_shell);
            }
          }
        }
      }
    }

    if (show_hinge) {
      // major [36, 236] to minor [62, 236]
      // offset y by t_shell inner and t_mould_wall_top outer
      // offset z to top of shell 6.5 - t_shell top * 2
      color(c="crimson") {
        translate(
          v=[
            36,
            236 + t_shell + t_mould_wall_top,
            6.5 - t_shell * 2,
          ]
        ) {
          mirror(v=[0, 0, 1]) {
            hinge(
              length=62 - 36,
              inner=true,
              arm_height=9 - 6.5 + t_shell * 2 + t_mould_base - r_hinge,
              dy=dy_hinge + max(t_mould_wall_bottom - t_mould_wall_top, 0),
            );
          }
        }
      }
    }
  }

  if (show_snap) {
    color(c="green") {
      snap(t=t_mould_base + 1 + 1.5 + t_shell * 2 + 4 + 2.5 + t_mould_base - d_snap, socket=true);
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
            mould_outer(t_mould_wall_bottom, r_mould_wall_bottom);
          }
        }
      }

      // layer 0 to 2.5
      color(c="pink") {
        translate(v=[0, 0, t_mould_base + 0]) {
          linear_extrude(h=2.5) {
            difference() {
              mould_outer(t_mould_wall_bottom, r_mould_wall_bottom);

              grow(thickness=t_shell, or=t_shell) {
                // major2d();
                screw2d(dxy_right=(show_pegstr ? 2 * t_shell : 0));
                body2d(dy_top=3 * t_shell, buttons=true, dy_bottom=(show_pegstr ? -2 * t_shell : 0));
                wheel2d(dr=(show_pegstr ? 2 * t_shell : 0));
                // slide2d();
              }
              grow(thickness=t_shell, or=0) {
                minor2d(dx_left=-3 * t_shell, dxy_right=t_shell);
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
              mould_outer(t_mould_wall_bottom, r_mould_wall_bottom);

              grow(thickness=t_shell, or=t_shell) {
                screw2d(dxy_right=(show_pegstr ? 2 * t_shell : 0));
                body2d(buttons=true, dy_bottom=(show_pegstr ? -2 * t_shell : 0));
                wheel2d(dr=(show_pegstr ? 2 * t_shell : 0));
                slide2d();
              }
              grow(thickness=t_shell, or=0) {
                major2d(dxy_left=-t_shell);
                minor2d(dx_left=-2 * t_shell, dxy_right=t_shell);
              }
            }
          }
        }
      }

      if (show_hinge) {
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
              dy=dy_hinge + max(t_mould_wall_top - t_mould_wall_bottom, 0),
            );
          }
        }
      }

      if (show_pegstr) {
        x = t_mould_wall_bottom;
        y = 10;
        z = 8;
        a = 25;

        // around the intersection of major and body
        translate(
          v=[
            30.0 - x - t_shell,
            210.25 - y - t_shell,
            t_mould_base + 6.5,
          ]
        ) {
          skew(ayz=a) {
            cuboid(
              size=[x, y, z],
              rounding=t_mould_wall_bottom / 2,
              except=[BOTTOM],
              anchor=LEFT + BOTTOM + FRONT,
            );
          }
        }

        // bottom of minor
        translate(
          v=[
            63 - x + t_shell + t_mould_wall_bottom,
            222.25 - y - t_shell,
            t_mould_base + 6.5,
          ]
        ) {
          skew(ayz=a) {
            cuboid(
              size=[x, y, z],
              rounding=t_mould_wall_bottom / 2,
              except=[BOTTOM],
              anchor=LEFT + BOTTOM + FRONT,
            );
          }
        }
      }

      if (show_snap) {
        color(c="orange") {
          snap(t=0, socket=false);
        }
      }

      if (show_pegstr) {
        color(c="limegreen") {
          difference() {
            pegstr_back(dz=dz_pegstr);
          }
        }
      }
    }

    if (show_pegstr) {

      // lining up holes for gluing
      pegstr_holes();

      // cut top of major
      translate(
        v=[
          -10,
          221.50,
          t_mould_base + 2.5,
        ]
      ) {
        cube(size=[45, 30, 4], center=false);
      }
      // trim major cutout
      translate(
        v=[
          30.00 - t_shell,
          201.50,
          t_mould_base,
        ]
      ) {
        cube(size=[30, 40, 6.5], center=false);
      }
      // cut top of minor
      translate(
        v=[
          44.60,
          228.55,
          t_mould_base,
        ]
      ) {
        cube(size=[60, 30, 6.5], center=false);
      }
    }
  }
}

module snap_puller(dx = 0, dz) {

  // across slide 40 - 56
  x = 2 * (t_shell + t_mould_wall_top + dx);

  translate(
    v=[
      40 - x / 2,
      -t_snap,
      dz,
    ]
  ) {
    cube(
      [
        56 - 40 + x,
        d_snap + t_snap + t_snap,
        t_mould_base,
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
      snap_puller(dx=t_snap * 2 + dx_snap, dz=9 + 2 * t_shell + t_mould_base + dz_top);
    }
  }
  if (show_bottom) {
    color(c="thistle") {
      snap_puller(dz=0);
    }
  }
}
