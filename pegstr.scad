// PEGSTR - Pegboard Wizard
// Design by Marius Gheorghescu, November 2014
// Update log:
// November 9th 2014
//		- first coomplete version. Angled holders are often odd/incorrect.
// November 15th 2014
//		- minor tweaks to increase rendering speed. added logo. 
// November 28th 2014
//		- bug fixes

// preview[view:north, tilt:bottom diagonal]

// width of the orifice
holder_x_size = 10; // [1:0.01:200]

// sides are flat
quantized_x_size = false;

// how many times to repeat the holder on X axis
holder_x_count = 1; // [1:20]

holder_x_spacing = 0; // [0:0.01:50]

// depth of the orifice
holder_y_size = 10; // [1:0.01:200]

// how many times to repeat the holder on Y axis
holder_y_count = 2; // [1:10]

// hight of the holder
holder_z_size = 15; // [1:0.001:120]

// base is at the bottom-most peg
quantized_z_size = false;

// how thick are the walls. Hint: 6*extrusion width produces the best results.
wall_thickness = 1.85; // [0:0.01:20]

// orifice corner radius (roundness). Needs to be less than min(x,y)/2.
corner_radius = 30; // [0:0.01:60]

// Use values less than 1.0 to make the bottom of the holder narrow
taper_ratio_x = 1.0; // [0:0.005:1]

// Use values less than 1.0 to make the bottom of the holder narrow
taper_ratio_y = 1.0; // [0:0.005:1]

// offset from the peg board, typically 0 unless you have an object that needs clearance
holder_offset = 0.0; // [0:0.01:50]

// what ratio of the holders bottom is reinforced to the plate [0.0-1.0]
strength_factor = 0.66; // [0:0.001:1]

// for bins: what ratio of wall thickness to use for closing the bottom
closed_bottom = 0.0; // [0:0.01:5]

// what percentage cut in the front (example to slip in a cable or make the tool snap from the side)
holder_cutout_side = 0.0; // [0:0.01:5]

// set an angle for the holder to prevent object from sliding or to view it better from the top
holder_angle = 0.0; // [-30:0.01:30]

// pin diameter
hole_size = 5.95; // [0:0.01:10]

// smaller hook as they are fragile and only used for insertion, not strength
hook_size = 5.35; // [0:0.01:10]

// metric inch
hole_spacing = 25.0; // [0:0.01:100]

// pin length
board_thickness = 0; // [0:0.01:10]

// longer pins for board_thickness 0
pin_extra_len = 4; // [0:0.01:5]

// flatten method, for debugging
flatten_method = "difference"; // [difference,intersection,union,none]

// flatten the top, to clips
flatten_top = true;

// flatten top further
flatten_top_additional = 0; // [0:0.001:2]

// flatten the bottom to lower pins
flatten_bottom = false;

// flatten bottom further, default to hex pin base: -epsilon + (hole_size - hole_size * sqrt(3) / 2) / 2
flatten_bottom_additional = 0.295; // [-1:0.001:10]

/* [Hidden] */

// what is the $fn parameter for holders
$fn = 32;

epsilon = 0.1;

clip_height = 2 * hole_size + 2;
echo(clip_height=clip_height);
echo();

taper_ratio = (taper_ratio_x + taper_ratio_y) / 2;
echo(taper_ratio=taper_ratio);
echo();

requested_total_x = (holder_x_size + wall_thickness) * holder_x_count + wall_thickness;
echo(requested_total_x=requested_total_x);

quantized_total_x = round(requested_total_x / hole_spacing) * hole_spacing + hole_size;
echo(quantized_total_x=quantized_total_x);

quantized_x = (quantized_total_x - wall_thickness) / holder_x_count - wall_thickness;
echo(quantized_x=quantized_x);

holder_x_size_actual = quantized_x_size ? quantized_x : holder_x_size;

holder_total_x = wall_thickness + holder_x_count * (wall_thickness + holder_x_size_actual) + holder_x_spacing * (holder_x_count - 1);
echo(holder_total_x=holder_total_x);

echo(holder_x_size_actual=holder_x_size_actual);
echo(bottom_x_size=holder_x_size_actual * taper_ratio_x);
echo();

holder_total_y = wall_thickness + holder_y_count * (wall_thickness + holder_y_size);
echo(holder_total_y=holder_total_y);

echo(holder_y_size=holder_y_size);
echo(bottom_y_size=holder_y_size * taper_ratio_y);
echo();

quantized_z = round(holder_z_size / hole_spacing) * hole_spacing + clip_height / 2 + hole_size / 2 - epsilon;
echo(quantized_z=quantized_z);

min_z = -clip_height / 2;
max_z = min_z + quantized_z;

holder_z_size_actual = quantized_z_size ? quantized_z : holder_z_size;
echo(holder_z_size_actual=holder_z_size_actual);

echo();

holder_roundness = min(corner_radius, holder_x_size_actual / 2, holder_y_size / 2);

// what is the $fn parameter
holder_sides = max(50, min(20, holder_x_size_actual * 2));

module round_rect_ex(x1, y1, x2, y2, z, r1, r2) {
  $fn = holder_sides;
  brim = z / 10;

  //rotate([0,0,(holder_sides==6)?30:((holder_sides==4)?45:0)])
  hull() {
    translate([-x1 / 2 + r1, y1 / 2 - r1, z / 2 - brim / 2])
      cylinder(r=r1, h=brim, center=true);
    translate([x1 / 2 - r1, y1 / 2 - r1, z / 2 - brim / 2])
      cylinder(r=r1, h=brim, center=true);
    translate([-x1 / 2 + r1, -y1 / 2 + r1, z / 2 - brim / 2])
      cylinder(r=r1, h=brim, center=true);
    translate([x1 / 2 - r1, -y1 / 2 + r1, z / 2 - brim / 2])
      cylinder(r=r1, h=brim, center=true);

    translate([-x2 / 2 + r2, y2 / 2 - r2, -z / 2 + brim / 2])
      cylinder(r=r2, h=brim, center=true);
    translate([x2 / 2 - r2, y2 / 2 - r2, -z / 2 + brim / 2])
      cylinder(r=r2, h=brim, center=true);
    translate([-x2 / 2 + r2, -y2 / 2 + r2, -z / 2 + brim / 2])
      cylinder(r=r2, h=brim, center=true);
    translate([x2 / 2 - r2, -y2 / 2 + r2, -z / 2 + brim / 2])
      cylinder(r=r2, h=brim, center=true);
  }
}

module old_pin(clip) {
  rotate([0, 0, 15])
    cylinder(r=hole_size / 2, h=board_thickness * 1.5 + epsilon, center=true, $fn=12);

  if (clip) {
    //
    rotate([0, 0, 90])
      intersection() {
        translate([0, 0, hole_size - epsilon])
          cube([hole_size + 2 * epsilon, clip_height, 2 * hole_size], center=true);

        // [-hole_size/2 - 1.95,0, board_thickness/2]
        translate([0, hole_size / 2 + 2, board_thickness / 2])
          rotate([0, 90, 0])
            rotate_extrude(convexity=5, $fn=20)
              translate([5, 0, 0])
                circle(r=(hole_size * 0.95) / 2);

        translate([0, hole_size / 2 + 2 - 1.6, board_thickness / 2])
          rotate([45, 0, 0])
            translate([0, -0, hole_size * 0.6])
              cube([hole_size + 2 * epsilon, 3 * hole_size, hole_size], center=true);
      }
  }
}

module pin(clip) {
  if (clip) {
    //
    rotate([0, 0, 90])
      intersection() {
        translate([0, 0, hole_size - epsilon])
          cube([hole_size + 2 * epsilon, clip_height, 2 * hole_size], center=true);

        // [-hole_size/2 - 1.95,0, board_thickness/2]
        translate([0, hole_size / 2 + 2, board_thickness / 2])
          rotate([0, 90, 0])
            rotate_extrude(convexity=5, $fn=20)
              translate([5, 0, 0])
                circle(r=(hook_size) / 2);

        translate([0, hole_size / 2 + 2 - 1.6, board_thickness / 2])
          rotate([45, 0, 0])
            translate([0, -0, hole_size * 0.6])
              cube([hole_size + 2 * epsilon, 3 * hole_size, hole_size], center=true);
      }
  } else {
    translate([0, 0, pin_extra_len / 2])
      rotate([0, 0, 30])
        cylinder(r=hole_size / 2, h=board_thickness * 1.5 + epsilon + pin_extra_len, center=true, $fn=6);
  }
}

module pinboard_clips() {
  rotate([0, 90, 0])for (i = [0:round(holder_total_x / hole_spacing)]) {
    for (j = [0:max(strength_factor, round(holder_z_size_actual / hole_spacing))]) {

      translate(
        [
          j * hole_spacing,
          -hole_spacing * (round(holder_total_x / hole_spacing) / 2) + i * hole_spacing,
          0,
        ]
      )
        pin(j == 0);
    }
  }
}

module pinboard(clips) {
  rotate([0, 90, 0])
    translate([-epsilon, 0, -wall_thickness - board_thickness / 2 + epsilon])
      hull() {
        translate(
          [
            -clip_height / 2 + hole_size / 2,
            -hole_spacing * (round(holder_total_x / hole_spacing) / 2),
            0,
          ]
        )
          cylinder(r=hole_size / 2, h=wall_thickness);

        translate(
          [
            -clip_height / 2 + hole_size / 2,
            hole_spacing * (round(holder_total_x / hole_spacing) / 2),
            0,
          ]
        )
          cylinder(r=hole_size / 2, h=wall_thickness);

        translate(
          [
            max(strength_factor, round(holder_z_size_actual / hole_spacing)) * hole_spacing,
            -hole_spacing * (round(holder_total_x / hole_spacing) / 2),
            0,
          ]
        )
          cylinder(r=hole_size / 2, h=wall_thickness);

        translate(
          [
            max(strength_factor, round(holder_z_size_actual / hole_spacing)) * hole_spacing,
            hole_spacing * (round(holder_total_x / hole_spacing) / 2),
            0,
          ]
        )
          cylinder(r=hole_size / 2, h=wall_thickness);
      }
}

module holder(negative) {
  for (x = [1:holder_x_count]) {
    for (y = [1:holder_y_count])
    /*		render(convexity=2)*/ {
      translate(
        [
          -holder_total_y /*- (holder_y_size+wall_thickness)/2*/ + y * (holder_y_size + wall_thickness) + wall_thickness,

          -holder_total_x / 2 + (holder_x_size_actual + wall_thickness) / 2 + (x - 1) * (holder_x_size_actual + wall_thickness) + wall_thickness / 2 + (x - 1) * holder_x_spacing,
          0,
        ]
      ) {
        rotate([0, holder_angle, 0])
          translate(
            [
              -wall_thickness * abs(sin(holder_angle)) - 0 * abs((holder_y_size / 2) * sin(holder_angle)) - holder_offset - (holder_y_size + 2 * wall_thickness) / 2 - board_thickness / 2,
              0,
              -(holder_z_size_actual / 2) * sin(holder_angle) - holder_z_size_actual / 2 + clip_height / 2,
            ]
          )
            difference() {
              if (!negative)

                round_rect_ex(
                  (holder_y_size + 2 * wall_thickness),
                  holder_x_size_actual + 2 * wall_thickness,
                  (holder_y_size + 2 * wall_thickness) * taper_ratio_y,
                  (holder_x_size_actual + 2 * wall_thickness) * taper_ratio_x,
                  holder_z_size_actual,
                  holder_roundness + epsilon,
                  holder_roundness * taper_ratio + epsilon
                );

              translate([0, 0, closed_bottom * wall_thickness])

              if (negative > 1) {
                round_rect_ex(
                  holder_y_size * taper_ratio_y,
                  holder_x_size_actual * taper_ratio_x,
                  holder_y_size * taper_ratio_y,
                  holder_x_size_actual * taper_ratio_x,
                  3 * max(holder_z_size_actual, hole_spacing),
                  holder_roundness * taper_ratio + epsilon,
                  holder_roundness * taper_ratio + epsilon
                );
              } else {
                round_rect_ex(
                  holder_y_size,
                  holder_x_size_actual,
                  holder_y_size * taper_ratio_y,
                  holder_x_size_actual * taper_ratio_x,
                  holder_z_size_actual + 2 * epsilon,
                  holder_roundness + epsilon,
                  holder_roundness * taper_ratio + epsilon
                );
              }

              if (!negative)
                if (holder_cutout_side > 0) {

                  if (negative > 1) {
                    hull() {
                      scale([1.0, holder_cutout_side, 1.0])
                        round_rect_ex(
                          holder_y_size * taper_ratio_y,
                          holder_x_size_actual * taper_ratio_x,
                          holder_y_size * taper_ratio_y,
                          holder_x_size_actual * taper_ratio_x,
                          3 * max(holder_z_size_actual, hole_spacing),
                          holder_roundness * taper_ratio + epsilon,
                          holder_roundness * taper_ratio + epsilon
                        );

                      translate([0 - (holder_y_size + 2 * wall_thickness), 0, 0])
                        scale([1.0, holder_cutout_side, 1.0])
                          round_rect_ex(
                            holder_y_size * taper_ratio_y,
                            holder_x_size_actual * taper_ratio_x,
                            holder_y_size * taper_ratio_y,
                            holder_x_size_actual * taper_ratio_x,
                            3 * max(holder_z_size_actual, hole_spacing),
                            holder_roundness * taper_ratio + epsilon,
                            holder_roundness * taper_ratio + epsilon
                          );
                    }
                  } else {
                    hull() {
                      scale([1.0, holder_cutout_side, 1.0])
                        round_rect_ex(
                          holder_y_size,
                          holder_x_size_actual,
                          holder_y_size * taper_ratio_y,
                          holder_x_size_actual * taper_ratio_x,
                          holder_z_size_actual + 2 * epsilon,
                          holder_roundness + epsilon,
                          holder_roundness * taper_ratio + epsilon
                        );

                      translate([0 - (holder_y_size + 2 * wall_thickness), 0, 0])
                        scale([1.0, holder_cutout_side, 1.0])
                          round_rect_ex(
                            holder_y_size,
                            holder_x_size_actual,
                            holder_y_size * taper_ratio_y,
                            holder_x_size_actual * taper_ratio_x,
                            holder_z_size_actual + 2 * epsilon,
                            holder_roundness + epsilon,
                            holder_roundness * taper_ratio + epsilon
                          );
                    }
                  }
                }
            }
      }
      // positioning
    }
    // for y
  }
  // for X
}

module build() {
  difference() {
    union() {

      pinboard();

      difference() {
        hull() {
          pinboard();

          intersection() {
            translate([-holder_offset - (strength_factor - 0.5) * holder_total_y - wall_thickness / 4, 0, 0])
              cube(
                [
                  holder_total_y + 2 * wall_thickness,
                  holder_total_x + wall_thickness,
                  2 * holder_z_size_actual,
                ], center=true
              );

            holder(0);
          }
        }

        if (closed_bottom * wall_thickness < epsilon) {
          holder(2);
        }
      }

      //color([0.2,0.5,0])
      difference() {
        holder(0);
        holder(2);
      }

      color(c="orange")
        pinboard_clips();
    }

    holder(1);
  }
}

module flatten() {
  // confirmed by measuring

  // extra epsilon to depth
  x = holder_total_y + epsilon + clip_height / 2 + wall_thickness + holder_offset + 10;
  dx = -x / 2 + epsilon + clip_height / 2 + wall_thickness + 5;

  // beyond bounds
  y = holder_total_x + hole_spacing;
  dy = 0;

  // clip top and front top are equal; shave off the middle
  z = quantized_z;
  dz = -z / 2 + min_z + flatten_top_additional;

  if (flatten_top) {
    color(c="blue")
      translate(v=[dx, dy, dz])
        cube(size=[x, y, z], center=true);
  }

  if (flatten_bottom) {
    dz_bottom = z / 2 + max_z - flatten_bottom_additional;

    color(c="green")
      translate(v=[dx, dy, dz_bottom])
        cube(size=[x, y, z], center=true);
  }
}

module pegstr() {
  if (flatten_method == "difference") {
    difference() {
      rotate([180, 0, 0]) build();
      flatten();
    }
  } else if (flatten_method == "intersection") {
    intersection() {
      rotate([180, 0, 0]) build();
      flatten();
    }
  } else if (flatten_method == "union") {
    union() {
      rotate([180, 0, 0]) build();
      flatten();
    }
  } else {
    rotate([180, 0, 0]) build();
  }
}

pegstr();

// include <caliper.scad>
// include <drill-bits.scad>
// include <nut-drivers.scad>
// include <bins.scad>
// include <multimeter.scad>
// include <voltmeter.scad>
