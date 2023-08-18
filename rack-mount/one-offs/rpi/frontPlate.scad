include <../../../config/common.scad>
include <../../../helper/common.scad>
include <../../../rack-mount/plateBase.scad>

vU = 2;
uHeight = 10;

plateScrewDiffV = uHeight*vU;
plateScrewDiffH = 180;

plateScrewToHEdge = 4.5;
plateScrewToVEdge = 5.5;

frontPlateThickness = 2.5;

frontPlateV = plateScrewDiffV + 2*plateScrewToHEdge;
frontPlateH = plateScrewDiffH + 2*plateScrewToVEdge;


plateScrewToBoxMin = 6;


length = 150;
resolution = 250;
period = PI/6;
shift = 0.0;
amplitudeFunction = function(x)  2;

module _frontPlateBody() {

    translate(v=[5,-3,-1])
        rotate(a=[180,0,0])
            sineWaveHull(length, resolution, amplitudeFunction, period+0.02, 2, 5);

    translate(v=[5,-3,4-1])
        rotate(a=[180,0,0])
            sineWaveHull(length, resolution, amplitudeFunction, period, 2 , 5);

    translate(v=[5,-3,8-1])
        rotate(a=[180,0,0])
            sineWaveHull(length, resolution, amplitudeFunction, period+0.03, 2.5, 5);

    translate(v=[5,-3,12-1])
        rotate(a=[180,0,0])
            sineWaveHull(length, resolution, amplitudeFunction, period+0.1, 3.3, 5);

    translate(v=[5,-3,16-1])
        rotate(a=[180,0,0])
            sineWaveHull(length, resolution, amplitudeFunction, period+0.1, 5, 5);

    translate(v=[5,-3,20-1])
        rotate(a=[180,0,0])
            sineWaveHull(length, resolution, amplitudeFunction, period+0.1, 6, 5);

    translate(v=[5,-3,24-1])
        rotate(a=[180,0,0])
            sineWaveHull(length, resolution, amplitudeFunction, period+0.08, 7, 5);
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
difference() {

    difference() {
        union() {
            plateBase(U=2, plateThickness=2.5, screwType="m4", filletR=2);
            rotate(a = [- 90, 0, 0])
                frontPlate();
        }

        union() {
            translate(v=[1,0,0])
                rotate(a=[0,-15, 0])
                    translate(v=[0,-50,0])
                        cube(size=[100, 100, 30]);

            translate(v=[160-1,0,0])
                mirror(v=[1,0,0]) {
                    rotate(a = [0, - 15, 0])
                        translate(v = [0, - 50, 0])
                            cube(size = [100, 100, 30]);
                }
        }

    }
    // lug holes
    union() {
        translate(v=[150,-3,-frontPlateThickness])
            cube(size=[5.2, 5.2, 3]);
        translate(v=[150-91.1,-3,-frontPlateThickness])
            cube(size=[5.2, 5.2, 3]);
    }
}
    for (i=[0:5]) {
        translate(v=[5,i*4 - 0.75,-10])
        cube(size=[150, 1.5, 20]);
    }
}