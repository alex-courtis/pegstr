# caliper

caliper.scad

filament: P1S eSUN PLA+
process: P1S eSUN PLA+
strength: wall loops: 6
support: snug grid
support: no remove small overhangs

# nut drivers

nut-drivers.scad

filament: P1S eSUN PLA+
process: P1S eSUN PLA+
strength: wall loops: 5
support: normal grid
support: no remove small overhangs

# nut drivers small

filament: P1S eSUN PLA+
process: P1S eSUN PLA+
strength: wall loops: 4
support: normal grid auto
support: no remove small overhangs

# pen holders small

filament: P1S eSUN PLA-HS
process: Generic PLA-HS
strength: wall loops: 5
support: normal manual
support: no remove small overhangs
print on base
paint pegs and hooks

# pen holders large

filament: P1S eSUN PLA-HS
process: P1S eSUN PLA-HS
strength: wall loops: 5
support: normal manual
support: no remove small overhangs

# driver bits

1/4 inch across = 6.34
37/128 inch diam = 7.3421875
25.4 / 4 * 2 / sqrt(3) = 7.33234841870824720926
25.4 / 4 * 2 / sqrt(3) * 1.025 = 7.51565712917595338949

manually set holder_sides = 6

filament: P1S eSUN PLA-HS
process: P1S eSUN PLA-HS
strength: wall loops: 5
support: normal manual
support: paint just pegs/clips

# pen holders tiny

filament: P1S eSUN PLA+
process: P1S eSUN PLA+
strength: wall loops: 5
support: normal manual
support: no remove small overhangs
print on base
paint pegs and hooks

# drill bits

drill-bits.scad

filament: P1S eSUN ABS+
process: P1S eSUN ABS+
strength: wall loops: 4
support: normal manual
support: no remove small overhangs
paint pegs and hooks
