difference() {
  pegstr();

  cutout_taper = 0.75;

  cutout_x = 25 / cutout_taper;
  cutout_y = 10 / cutout_taper;

  cutout_depth = 15;

  // lead hole
  color(c="pink", alpha=0.5)
    translate(
      v=[
        -holder_offset - wall_thickness - cutout_y - holder_y_size + cutout_y,
        cutout_x + holder_x_size / 2 - cutout_x,
        -clip_height / 2 + holder_height / 2 - cutout_depth,
      ]
    ) 
      linear_extrude(height=holder_height, scale=cutout_taper, center=true)
        square(size=[cutout_y * 2, cutout_x * 2], center=true);
}
