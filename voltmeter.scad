difference() {
  pegstr();

  cutout_taper = 0.9;

  cutout_x = 25 / cutout_taper;
  cutout_y = 36 / cutout_taper;

  cutout_inset = 7.1;

  color(c="red")
    translate(
      v=[
        -cutout_x / 2 - holder_offset - wall_thickness * 2 - cutout_inset,
        0,
        -clip_height / 2 + holder_height / 2,
      ]
    )
      linear_extrude(height=holder_height + epsilon, scale=cutout_taper, center=true)
        square(size=[cutout_x, cutout_y], center=true);
}
