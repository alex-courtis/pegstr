// filament: P1S eSUN PLA-HS
// process: P1S eSUN PLA-HS
//
// strength: wall loops: 6
// support: build plate only
// support: raft/interface: PLA/PETG

include <pegstr.scad>

holder_x_size = 17;
holder_y_size = 5.5;

holder_height = 37.5;

wall_thickness = 1.0;

// holder_x_count = 1;
holder_y_count = 1;

corner_radius = 0;

// taper_ratio = 1.0;

holder_offset = 5.0;

strength_factor = 0.0;

// closed_bottom = 0.0;

// holder_cutout_side = 0.0;

// holder_angle = 0.0;

// hole_spacing = 25.0;
// hole_size = 5.8;
// board_thickness = 0;

// pin_extra_len = 3;

rotate([180, 0, 0]) pegstr();
