// add to hole diameter
hole_wiggle = 0.5;

// add to diameter and twice depth
countersink = 1.25;

// flip to generate just text
render_text = true;
render_holder = false;

text_size = 7;

text_depth = 1;

// back to front, left to right
bits = [
  [
    [7.0, 102],
    [6.5, 99],
    [6.0, 94],
    [5.5, 92],
    [5.0, 84],
    [4.5, 81],
    [4.0, 74],
  ],
  [
    [3.5, 70],
    [3.2, 64],
    [3.0, 60],
    [2.5, 56],
    [2.0, 49],
    [1.5, 40],
    [1.0, 36],
  ],
];

if (render_holder) {

  // holder itself
  difference() {
    union() {
      pegstr();

      for (row = [0:1:len(bits) - 1]) {
        for (col = [0:1:holder_x_count - 1]) {

          d = bits[row][col][0];
          dw = d + hole_wiggle;
          l = bits[row][col][1];

          translate(
            v=[
              -holder_offset - holder_y_size / 2 - wall_thickness - row * (holder_y_size + wall_thickness),
              (col + 0.5 - holder_x_count / 2) * (holder_x_size + wall_thickness),
              holder_z_size / 2 - clip_height / 2,
            ]
          ) {
            union() {
              difference() {

                // fill in the holes
                color(c="blue")
                  cylinder(h=holder_z_size, d=holder_x_size + wall_thickness, center=true, $fn=holder_sides);

                // shift back a bit
                translate(v=[holder_x_size / 3 - countersink, 0, 0]) {

                  // specific size hole
                  color(c="red")
                    translate(v=[0, 0, -holder_z_size / 2])
                      cylinder(h=l, d=dw, center=true, $fn=holder_sides * 2);

                  // countersink
                  color(c="green")
                    translate(v=[0, 0, -(holder_z_size - countersink) / 2])
                      cylinder(h=countersink, d1=dw + countersink, d2=dw, center=true, $fn=holder_sides * 2);
                }
              }
            }
          }
        }
      }
    }
  }
}

if (render_text) {
  for (row = [0:1:len(bits) - 1]) {
    for (col = [0:1:holder_x_count - 1]) {

      d = bits[row][col][0];

      translate(
        v=[
          -holder_offset - holder_y_size / 2 - wall_thickness - row * (holder_y_size + wall_thickness),
          (col + 0.5 - holder_x_count / 2) * (holder_x_size + wall_thickness),
          holder_z_size / 2 - clip_height / 2,
        ]
      ) {
        // text
        color(c="yellow")
          translate(v=[-holder_x_size * 0.35, 0, -holder_z_size / 2 + text_depth])
            rotate(a=180, v=[0, 1, 0])
              rotate(a=90, v=[0, 0, 1])
                linear_extrude(height=text_depth, center=false)
                  text(size=text_size, halign="center", valign="baseline", text=str(d));
      }
    }
  }
}
