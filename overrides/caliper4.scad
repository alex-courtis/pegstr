include <BOSL2/std.scad>

t_shell = 0.5;
r_shell = t_shell * 2;

t_mould = 3;
r_mould = 4;
dz_mould = 0.4;
z_mould = 6.5 + dz_mould;

x_max_model = 77;
y_max_model = 236;
z_max_model = 17;

module grow(t, or) {
  shell2d(thickness=t, or=or)
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
        grow(t_shell, r_shell)
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
      grow(t_shell, r_shell)
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
      grow(t_shell, r_shell)
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
      grow(t_shell, r_shell)
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
        grow(t_shell, r_shell)
          slide2d();
}

module model3d() {
  major3d();
  minor3d();
  body3d();
  wheel3d();
  slide3d();
}

module model2d() {
  major2d();
  minor2d();
  body2d();
  wheel2d();
  slide2d();
}

module test_mould() {
  intersection() {
    translate(v=[-5, 80, 0]) {
      cube([x_max_model * 1.2, y_max_model * 1.2, 20]);
    }

    difference() {
      linear_extrude(h=z_mould) {
        grow(t_mould, r_mould) {
          model2d();
        }
      }
      translate(v=[0, 0, dz_mould]) {
        model3d();
      }
    }
  }
}

render() model3d();

// render() test_mould();
