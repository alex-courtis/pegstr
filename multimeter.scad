// Setting height to 84.753 results in an exactly flat base. Work out how this can be derived.

cutout_bottom_x = -holder_total_x / 2 + 27;
cutout_bottom_y = holder_total_y / 2 - wall_thickness - 5;

difference() {
  pegstr();

  // depth and width
  translate([-cutout_bottom_y, -cutout_bottom_x, 0])

    // lift above bottom wall
    translate([0, 0, -wall_thickness * closed_bottom + epsilon])

      // move to the quadrant
      translate([-holder_total_y / 2, holder_total_x / 2, 0])
        // chamber and walls
        translate(
          v=[
            -holder_offset - holder_total_y / 2,
            0,
            holder_height / 2 - clip_height / 2,
          ]
        )

          color(c="green")
            cube([holder_total_y, holder_total_x, holder_height], center=true);
}
