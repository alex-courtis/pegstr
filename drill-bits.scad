// multiply by bit size for the hole diameter
hole_wiggle = 1.01;

// constant depth and extra diameter
countersink = 0.25;

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

union() {
  pegstr();

  for (row = [0:1:len(bits) - 1]) {
    for (col = [0:1:holder_x_count - 1]) {

      d = bits[row][col][0];
      l = bits[row][col][1];

      translate(
        v=[
          -holder_offset - holder_y_size / 2 - wall_thickness - row * (holder_y_size + wall_thickness),
          (col + 0.5 - holder_x_count / 2) * (holder_x_size + wall_thickness),
          holder_height / 2 - clip_height / 2,
        ]
      ) {
        difference() {

          // fill in the holes
          color(c="blue")
            cylinder(h=holder_height, d=holder_x_size + wall_thickness, center=true, $fn=holder_sides);

          // specific size hole
          color(c="red")
            translate(v=[0, 0, -holder_height / 2])
              cylinder(h=l, d=d * hole_wiggle, center=true, $fn=holder_sides * 2);
          // countersink
          color(c="green")
            translate(v=[0, 0, -(holder_height - countersink) / 2])
              cylinder(h=countersink, d1=d + countersink, d2=d * hole_wiggle, center=true, $fn=holder_sides * 2);
        }
      }
    }
  }
}
