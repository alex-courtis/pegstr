// filament: P1S eSUN PLA-HS
// process: P1S eSUN PLA-HS
//
// strength: wall loops: 6
// support: normal grid
// support: no remove small overhangs

// add after pegstr()

_holder_y_size = 7;
_wall_thickness = 2.0;
_holder_offset = 16;

// we want 14mm standoffs
color(c="red")
  translate(v=[-_holder_offset + _wall_thickness / 2, 0, -13.7])
    cube([_wall_thickness * 3, 12, 24], center=true);

