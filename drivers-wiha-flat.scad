difference() {
  pegstr();

  color(c="red", alpha=1)
    rotate(a=45, v=[0, 1, 0])
      translate(v=[-100, 0, 0])
        cube(
          [
            49,
            38,
            30,
          ], center=true
        );
}
