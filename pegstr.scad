// PEGSTR - Pegboard Wizard
// Design by Marius Gheorghescu, November 2014
// Update log:
// November 9th 2014
//		- first coomplete version. Angled holders are often odd/incorrect.
// November 15th 2014
//		- minor tweaks to increase rendering speed. added logo. 
// November 28th 2014
//		- bug fixes

// TODO
// closed bottom factor nonbinary
// angle adds offset

// preview[view:north, tilt:bottom diagonal]

/* [Size] [x] */

// adjusts holder_x_size to fit entire width
quantized_x_size = false;

// width of the orifice
holder_x_size = 10; // [1:0.01:200]

// how many times to repeat the holder on X axis
holder_x_count = 1; // [1:20]

// Use values less than 1.0 to make the bottom of the holder narrow
taper_ratio_x = 1.0; // [0:0.001:1]

// adjusts holder_x_spacing to fit entire width
quantized_x_spacing = false;

// spacing greater than wall thickness
holder_x_spacing = 0; // [0:0.01:50]

/* [Size] [y] */

// depth of the orifice
holder_y_size = 10; // [1:0.01:200]

// how many times to repeat the holder on Y axis
holder_y_count = 2; // [1:10]

// Use values less than 1.0 to make the bottom of the holder narrow
taper_ratio_y = 1.0; // [0:0.001:1]

// offset from the peg board, typically 0 unless you have an object that needs clearance
holder_offset = 0.0; // [0:0.01:50]

/* [Size] [z] */

// base is at the bottom-most peg
quantized_z_size = false;

// hight of the holder
holder_z_size = 15; // [1:0.001:200]

/* [Shape] */

// how thick are the walls. Hint: 6*extrusion width produces the best results.
wall_thickness = 1.85; // [0:0.01:20]

// orifice corner radius (roundness). Needs to be less than min(x,y)/2.
corner_radius = 30; // [0:0.01:60]

// what ratio of the holders bottom is reinforced to the plate [0.0-1.0]
strength_factor = 0.66; // [0:0.00001:1]

// for bins: what ratio of wall thickness to use for closing the bottom
closed_bottom = 0.0; // [0:0.01:30]

// what ratio of the holders bottom is closed
closed_bottom_factor = 0.0; // [0:0.01:1]

// lip above closed bottom
closed_bottom_lip = 0.0; // [0:0.01:50]

// what percentage cut in the front (example to slip in a cable or make the tool snap from the side)
holder_cutout_side = 0.0; // [0:0.01:1.5]

// set an angle for the holder to prevent object from sliding or to view it better from the top
holder_angle = 0.0; // [-90:0.01:90]

/* [Flattening] */

// flatten method, for debugging
flatten_method = "difference"; // [difference,intersection,union,none]

// flatten the top, to clips
flatten_top = true;

// adjust top flattening
flatten_top_dz = 0; // [-10:0.001:10]

// flatten the bottom to lower pins
flatten_bottom = false;

// adjust bottom flattening further than hex pin base
flatten_bottom_dz = 0; // [-10:0.001:50]

// flatten to the sides of pinboard
flatten_sides = false;

// adjust sides flattening
flatten_sides_dy = 0; // [-10:0.001:20]

// flatten to the front of pinboard
flatten_front = false;

// adjust front flattening
flatten_front_dx = 0; // [-10:0.001:10]

/* [Pins] */

// pin diameter
hole_size = 5.95; // [0:0.01:10]

// smaller hook as they are fragile and only used for insertion, not strength
hook_size = 5.20; // [0:0.01:10]

// metric inch
hole_spacing = 25.0; // [0:0.01:100]

// pin length
board_thickness = 0; // [0:0.01:10]

// longer pins for board_thickness 0
pin_extra_len = 4; // [0:0.01:5]

/* [Tuning] */

// what is the $fn parameter for holders
$fn = 200;

// what is the $fn parameter for rounded rects
holder_sides_fn = 200;

epsilon = 0.1;

clip_height = 2 * hole_size + 2;
echo(clip_height=clip_height);
echo();

taper_ratio = (taper_ratio_x + taper_ratio_y) / 2;
echo(taper_ratio=taper_ratio);
echo();

//
// x
//
assert(!(quantized_x_size && quantized_x_spacing), "cannot use quantized x size and even spacing");

echo(holder_x_size=holder_x_size);

requested_total_x = (holder_x_size + wall_thickness) * holder_x_count + wall_thickness + (holder_x_count - 1) * holder_x_spacing;
echo(requested_total_x=requested_total_x);

quantized_total_x = round(requested_total_x / hole_spacing) * hole_spacing + hole_size;
echo(quantized_total_x=quantized_total_x);

quantized_x = (quantized_total_x - wall_thickness) / holder_x_count - wall_thickness;
echo(quantized_x=quantized_x);

quantized_spacing = (quantized_total_x - holder_x_count * (holder_x_size + wall_thickness) - wall_thickness) / (holder_x_count - 1);
echo(quantized_spacing=quantized_spacing);

holder_x_spacing_actual = (quantized_x_spacing && quantized_spacing > 0 && holder_x_count > 0) ? quantized_spacing : holder_x_spacing;
echo(holder_x_spacing_actual=holder_x_spacing_actual);

holder_x_size_actual = quantized_x_size ? quantized_x : holder_x_size;

holder_total_x = wall_thickness + holder_x_count * (wall_thickness + holder_x_size_actual) + holder_x_spacing_actual * (holder_x_count - 1);
echo(holder_total_x=holder_total_x);

echo(holder_x_size_actual=holder_x_size_actual);
echo(bottom_x_size=holder_x_size_actual * taper_ratio_x);
echo();

//
// y
//
echo(holder_y_size=holder_y_size);

holder_total_y = wall_thickness + holder_y_count * (wall_thickness + holder_y_size);
echo(holder_total_y=holder_total_y);

echo(bottom_y_size=holder_y_size * taper_ratio_y);
echo();

//
// z
//
echo(holder_z_size=holder_z_size);

holder_z_size_closed_bottom = holder_z_size + ( (strength_factor > 0 || closed_bottom_factor > 0) ? closed_bottom * wall_thickness : 0);
echo(holder_z_size_closed_bottom=holder_z_size_closed_bottom);

quantized_z = round(holder_z_size_closed_bottom / hole_spacing) * hole_spacing + clip_height / 2 + hole_size / 2 - epsilon;
echo(quantized_z=quantized_z);

min_z = -clip_height / 2;
max_z = min_z + quantized_z;

holder_z_size_actual = quantized_z_size ? quantized_z : holder_z_size_closed_bottom;
echo(holder_z_size_actual=holder_z_size_actual);

echo();

//
// misc
//
holder_roundness = min(corner_radius, holder_x_size_actual / 2, holder_y_size / 2);

// what is the $fn parameter
holder_sides = max(50, min(20, holder_x_size_actual * 2));

module round_rect_ex(x1, y1, x2, y2, z, r1, r2) {
  $fn = holder_sides_fn;
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

          -holder_total_x / 2 + (holder_x_size_actual + wall_thickness) / 2 + (x - 1) * (holder_x_size_actual + wall_thickness) + wall_thickness / 2 + (x - 1) * holder_x_spacing_actual,
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
                if (closed_bottom_factor == 0) {
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

                    // preserve the closed bottom
                    translate([0, 0, closed_bottom_factor > 0 ? wall_thickness * closed_bottom + closed_bottom_lip : 0])

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

  // covers the entire unit, with an entire clip_height out the back, top stops at hook top
  x = clip_height + holder_total_y + holder_offset;
  dx = clip_height - x / 2;

  y = max(holder_total_x, quantized_total_x) + epsilon * 2;
  dy = 0;

  z = max_z - min_z;
  dz = z / 2 + min_z;

  if (flatten_top) {
    dz = dz - z + flatten_top_dz;

    // double sized to cover angled holders
    dx = dx - x / 2;
    x = x * 2;

    color(c="blue")
      translate(v=[dx, dy, dz])
        cube(size=[x, y, z], center=true);
  }

  if (flatten_bottom) {
    hole_hex_delta = -epsilon + (hole_size - hole_size * sqrt(3) / 2) / 2;

    dz = dz + z - hole_hex_delta - flatten_bottom_dz;

    color(c="green")
      translate(v=[dx, dy, dz])
        cube(size=[x, y, z], center=true);
  }

  if (flatten_sides) {
    dy = dy + y - flatten_sides_dy;

    color(c="yellow")
      translate(v=[dx, dy, dz])
        cube(size=[x, y, z], center=true);

    color(c="yellow")
      translate(v=[dx, -dy, dz])
        cube(size=[x, y, z], center=true);
  }

  if (flatten_front) {
    dx = dx - x + flatten_front_dx;

    color(c="red")
      translate(v=[dx, dy, dz])
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

// include <overrides/caliper.scad>
// include <overrides/drill-bits.scad>
// include <overrides/nut-drivers.scad>
// include <overrides/multimeter.scad>
// include <overrides/voltmeter.scad>
// include <overrides/multimeter3.scad>
// include <overrides/drivers-wiha-flat.scad>
// include <overrides/bins-small-tall.scad>
// include <overrides/bins-small-short.scad>
// include <overrides/bins-pry.scad>
// include <overrides/bins-eraser-lead.scad>
// include <overrides/isopropyl-acetone-holder.scad>
// include <overrides/compass.scad>
// include <overrides/bins-pry-tall.scad>
// include <overrides/bins-pry-short.scad>
// include <overrides/drill-bits-conical.scad>
// include <overrides/caliper3.scad>
