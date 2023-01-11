
include <./common.scad>
include <./rack/screws.scad>
include <./rockpro/rockpro.scad>

module screwRiser(innerD, outerD, height) {
    difference() {
        cylinder(d=outerD, h=height, $fn=64);
        cylinder(d=innerD, h=height, $fn=64);
    }
}

module rockProScrewMounts() {
    for (i=[0:3]) {
        p = mountPoints[i];
        translate(v=[p[0], p[1], p[2]])
            screwRiser(innerD=2.8, outerD=8, height=7);
    }
}

//rockProScrewMounts();

