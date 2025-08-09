difference() {
  pegstr();

  union() {
    color(c="red", alpha=1)
      rotate(a=60, v=[0, 1, 0])
        translate(v=[-100, 0, 0])
          cube(
            [
              42.1,
              38,
              40,
            ], center=true
          );

    color(c="green", alpha=1)
      translate(v=[0, -95.25, 0])
        cube(
          [
            200,
            10,
            200,
          ], center=true
        );

    color(c="blue", alpha=1)
      translate(v=[0, 95.25, 0])
        cube(
          [
            200,
            10,
            200,
          ], center=true
        );

    color(c="yellow", alpha=1)
      rotate(a=60, v=[0, 1, 0])
        translate(v=[-84.09, 0, 23.255])
          cube(
            [
              120,
              200,
              40,
            ], center=true
          );
  }
}
