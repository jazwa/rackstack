include <./common.scad>


*plateBase(U=2, plateThickness=3, screwType="m4", filletR=2);

module plateBase(U, plateThickness, screwType, screwToXEdge=4.5, screwToYEdge=4.5, filletR=2) {

    assert(floor(U) == U && U > 0)
    assert(plateThickness > 0);

    screwDx = rackMountScrewWidth;
    screwDy = uDiff * U;

    plateLength = screwDx + 2*screwToXEdge;
    plateHeight = screwDy + 2*screwToYEdge;

    translate(v=[-screwToXEdge,-screwToYEdge,-plateThickness]) // easier to work with
    difference() {
        base();

        mirror4XY(p=[screwToXEdge, screwToYEdge], dx=screwDx, dy=screwDy)
        translate(v=[0,0,plateThickness])
        cylinder(r=screwRadiusSlacked(screwType), h=inf, center=true);
    }

    module base() {
        minkowski() {
            translate(v=[filletR, filletR, 0])
            cube(size = [plateLength-2*filletR, plateHeight-2*filletR, plateThickness]);
            cylinder(r=filletR, h=eps);
        }
    }

}