difference() {
  pegstr();

  color(c="red", alpha=1)
    translate(
      v=[
        -holder_total_y - holder_offset - epsilon,
        -30,
        min_z - epsilon,
      ]
    )
      cube(
        [
          10,
          70,
          68.5,
        ], center=false
      );
}
