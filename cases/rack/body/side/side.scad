include <../../../misc/magnet.scad>
include <../../../math.scad>
$fn=64;

_height = 210;
_depth = 200;

_thickness = 5;

holeOffset = 10;

module _base() {
    difference() {
        cube(size = [_height, _depth, _thickness], center=true);
        union() {
            translate(v = [0, 0, 20])
                minkowski() {
                    sphere(r = 20);
                    cube(size = [_height - 34, _depth - 34, 1], center = true);

                }
            // handles
            handleLength = 80;
            translate(v=[0, _depth/2, _thickness+5.5])
                minkowski() {
                    sphere(r=10);
                    cube(size=[handleLength, 10, 1], center=true);
                }
            translate(v=[0, -_depth/2, _thickness+5.5])
                minkowski() {
                    sphere(r=10);
                    cube(size=[handleLength, 10, 1], center=true);
                }
        }
    }
}

module magnetMount(h) {
    slack = 0.2;
    difference() {
        cylinder(h = h, r=magnetR*2);
        translate(v=[0,0,h-magnetH])
        cylinder(h = magnetH, r = magnetR+slack);
    }
}


module side() {
    magnetMountOffsetX = 95;
    magnetMountOffsetY = 90;
    difference() {
        union() {
            // align _base to positive z plan
            translate(v = [0, 0, _thickness / 2])
                _base();

            // magnet mounts (no holes)
            for (i=mirror4XY(midpoint=[0,0,0], offsetX=magnetMountOffsetX, offsetY=magnetMountOffsetY)) {
                translate(v=i)
                    cylinder(h=_thickness, r=2*magnetR);
            }
        }

        // magnet mount holes
        for (i=mirror4XY(midpoint=[0,0,_thickness-magnetH], offsetX=magnetMountOffsetX, offsetY=magnetMountOffsetY)) {
            translate(v=i)
                cylinder(h=magnetH, r=magnetR);
        }
    }
}


difference() {
    side();

    union() {
        for (i=[0:7]) {
            translate(v=[i*15 - 52.5,0,0])
            minkowski() {
                cube(size = [2, 100, 10], center = true);
                sphere(r=2);
            }
        }

    }
}


