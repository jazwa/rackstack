include <../rack-tray/rack-tray.scad>
include <../common.scad>
include <../rack/screws.scad>
include <./rockpro.scad>

vU = 3;
uHeight = 10;

plateScrewDiffV = uHeight*vU;
plateScrewDiffH = 180;

plateScrewToHEdge = 4.5;
plateScrewToVEdge = 5.5;

frontPlateThickness = 2;

frontPlateV = plateScrewDiffV + 2*plateScrewToHEdge;
frontPlateH = plateScrewDiffH + 2*plateScrewToVEdge;


plateScrewToBoxMin = 6;

module _frontPlateBody() {
    translate(v=[-plateScrewToVEdge,0,-plateScrewToHEdge])
        cube(size=[frontPlateH,frontPlateThickness,frontPlateV]);
}

module _plateHole() {
    rotate(a=[90,0,0])
        cylinder(r=m4RadiusSlacked, h=inf, center=true);
}


module frontPlate() {

    difference() {
        _frontPlateBody();

        union() {
            // TODO: introduce helper modules for this pattern
            _plateHole();

            translate(v=[plateScrewDiffH,0,0])
                _plateHole();

            translate(v=[0,0,plateScrewDiffV])
                _plateHole();

            translate(v=[plateScrewDiffH,0,plateScrewDiffV])
                _plateHole();
        }
    }
}

difference() {
    frontPlate();
    union() {
        translate(v = [13, 0, - 10])
            cube(size = [300, 100, 100]);

        translate(v=[6,0,-2])
            cube(size=[5.5,5.5,5.5]);

        translate(v=[6,0,20-2])
            cube(size=[5.5,5.5,5.5]);
    }
}



// todo use library constants
// TODO these risers are prone to snapping off
module screwRiser(height) {
    difference() {
        cylinder(d=5, h=height, $fn=64);
        cylinder(d=2.88, h=height, $fn=64);
    }
}

module mountPoints_N(cylHeight, cylRad1, cylRad2, cylFn, center) {
    for (i=[0:3]) {
        p = mountPoints[i];
        translate(v=[p[0], p[1], p[2]])
            cylinder(r1=cylRad1, r2=cylRad2, h=cylHeight, $fn=cylFn, center=center);
    }

}

module rockProScrewMounts() {
    for (i=[0:3]) {
        p = mountPoints[i];
        translate(v=[p[0], p[1], p[2]])
            screwRiser(5);
    }
}


module rockProDualTray() {


    trayBody();
    translate(v=[9,8,trayBottomThickness])
        rockProScrewMounts();

    translate(v=[9 + pcbDimensions[0],8,trayBottomThickness])
        rockProScrewMounts();

}

*difference() {
    rockProDualTray();
    // file specific bottom holes
    union() {
        translate(v = [10, 15, 0])
            minkowski() {
                cube(size = [69, 100, 5]);
                cylinder(r = 1);
            }

        translate(v=[88,15,0])
            minkowski() {
                cube(size = [69, 100, 5]);
                cylinder(r=1);
            }
    }
}