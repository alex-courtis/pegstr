render()
  difference() {
    pegstr();

    color(c="red", alpha=1)
      translate(
        v=[
          holder_x_size + 14.047 - 1.522 + 2.548,
          ty - wall_thickness * 2,
          tz - 68.4,
        ]
      )
        cube(
          [
            70,
            wall_thickness * 2.5,
            68.4,
          ], center=false
        );
  }
