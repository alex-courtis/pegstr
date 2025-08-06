#!/bin/sh

for c in \
	"nut-drivers-wiha-1-3-flat" \
	"nut-drivers-wiha-4-6-flat" \
	"nut-drivers-wiha-7-flat" \
	"nut-drivers-wiha-1-3-big-end" \
	"nut-drivers-wiha-4-6-big-end" \
	"nut-drivers-wiha-7-big-end" \
	"nut-drivers-wiha-1-3-little-end" \
	"nut-drivers-wiha-4-6-little-end" \
	"nut-drivers-wiha-7-little-end"
do
	echo "----${c}----"
	openscad-nightly \
		pegstr.scad \
		--backend Manifold \
		-p pegstr.json \
		-P "${c}" \
		-o "${c}.stl"
done
