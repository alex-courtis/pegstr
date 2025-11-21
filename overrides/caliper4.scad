include <BOSL2/std.scad>

$fn = 200;

t_shell = 0.5;
r_shell = t_shell * 1;

t_mould_wall = 3;
r_mould_wall = t_mould_wall * 1;

t_mould_base = 0.4;

dy_mould = -120;

module grow(thickness, or) {
  shell2d(thickness=thickness, or=or)
    children();
  children();
}

module major2d() {
  polygon(
    [
      [0, 222],
      [7, 229],
      [36, 236],
      [47, 236],
      [47, 221],
      [33, 221],
      [33, 209],
      [7, 215],
      [0, 222],
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
      [47, 236],
      [62, 236],
      [73, 232],
      [77, 228.5],
      [73, 225],
      [63, 221],
      [47, 221],
      [47, 236],
    ]
  );
}

module minor3d() {
  color(c="orange")
    linear_extrude(h=6.5)
      minor2d();
}

module body2d() {
  polygon(
    [
      [33, 221],
      [63, 221],
      [63, 193],
      [70, 193],
      [70, 186],
      [63, 186],
      [63, 159],
      [33, 159],
      [26, 168],
      [33, 183],
      [33, 221],
    ]
  );
}

module body3d() {
  color(c="brown")
    linear_extrude(h=17)
      body2d();
}

module wheel2d() {
  translate(v=[34, 152.5])
    circle(r=5.5);
  polygon(
    [
      [33, 159],
      [40, 159],
      [40, 148],
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
  body2d();
  wheel2d();
  slide2d();
}

module model3d() {
  major3d();
  minor3d();
  body3d();
  wheel3d();
  slide3d();
}

module mould_outer() {
  grow(thickness=t_mould_wall, or=r_mould_wall) {
    grow(thickness=t_shell, or=r_shell) {
      major2d();
      minor2d();
      body2d();
      wheel2d();
      slide2d();
    }
  }
}

module mould() {

  // base
  color(c="blue") {
    linear_extrude(h=t_mould_base) {
      mould_outer();
    }
  }

  // layer 0 2.5
  color(c="pink") {
    translate(v=[0, 0, t_mould_base]) {
      linear_extrude(h=2.5) {
        difference() {
          mould_outer();

          grow(thickness=t_shell, or=r_shell) {
            // major2d();
            minor2d();
            body2d();
            wheel2d();
            // slide2d();
          }
        }
      }
    }
  }

  // layer 1 9
  color(c="brown") {
    translate(v=[0, 0, t_mould_base + 2.5]) {
      linear_extrude(h=9 - 2.5) {
        difference() {
          mould_outer();

          grow(thickness=t_shell, or=r_shell) {
            major2d();
            minor2d();
            body2d();
            wheel2d();
            slide2d();
          }
        }
      }
    }
  }
}

render() {
  translate(v=[100, dy_mould, t_mould_base]) {
    model3d();
  }

  back_half(s=200) {
    translate(v=[0, dy_mould, 0]) {
      mould();
    }
  }
}
