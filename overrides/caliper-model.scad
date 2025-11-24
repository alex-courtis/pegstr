include <BOSL2/std.scad>

// $fn = 200;

module major2d() {
  polygon(
    [
      [0, 222],
      [7, 229],
      [36, 236],
      [46, 236],
      [46, 221],
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
      [46, 236],
      [62, 236],
      [73, 232],
      [77, 228.5],
      [73, 225],
      [63, 221],
      [46, 221],
      [46, 236],
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

module body2d(dy_bottom = 0, buttons = false) {
  dx_button = buttons ? -3 : 0;
  y1_button = buttons ? 186 : 0;
  y2_button = buttons ? 209.7 : 0;
  polygon(
    [
      [33, 221],
      [63, 221],
      [63, 159 + dy_bottom],
      [33, 159 + dy_bottom],
      [33, 159],
      [26, 168],
      [33, 183],
      [33 + dx_button, y1_button],
      [33 + dx_button, y2_button],
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

module caliper_model3d() {
  major3d();
  minor3d();
  screw3d();
  body3d();
  wheel3d();
  slide3d();
}

module caliper_model2d() {
  major2d();
  minor2d();
  screw2d();
  body2d();
  wheel2d();
  slide2d();
}

// render() caliper_model3d();
