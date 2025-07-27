r = 3;
dz = -clip_height / 2;

difference() {
  pegstr();

  color(c="red") {
    translate(
      v=[
        -holder_offset - wall_thickness - holder_y_size / 2,
        0,
        dz,
      ]
    )
      rotate(a=90, v=[1, 0, 0])
        cylinder(r=r, h=quantized_total_x, center=true);
  }
}
