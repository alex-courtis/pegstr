// filament: P1S eSUN PLA+
// process: P1S eSUN PLA+
//
// strength: wall loops: 6
// support: build plate only
// support: raft/interface: PLA/PETG

include <pegstr.scad>

holder_x_size = 20;
holder_y_size = 20;

holder_height = 37.5;

wall_thickness = 1;

// holder_x_count = 1;
holder_y_count = 1;

// corner_radius = 30;

// driver radius ~ 18.5mm
// desired top ~20mm
// 18.5 / 20 = 0.925
taper_ratio = 0.925;

// tool top radius ~ 18mm
// 18 - 20 / 2 - 1 = 7
holder_offset = 7;

// strength_factor = 0.66;

// closed_bottom = 0.0;

// holder_cutout_side = 0.0;

// holder_angle = 0.0;

// hole_spacing = 25.0;
// hole_size = 5.8;
// board_thickness = 0;

// pin_extra_len = 3;

hook_size = 5;

rotate([180, 0, 0]) pegstr();
