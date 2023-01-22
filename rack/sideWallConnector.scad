include <./config.scad>
include <../helper/screws.scad>

sideWallConnectorSlotWidth = 7;

sideWallConnW = 7;
sideWallConnD = 20;
sideWallConnLugDepression = 2;

yBarScrewHoleToOuterYEdge = 3.5;
yBarScrewHoleToFrontXEdge = 16;

module sideWallConnector_N() {
    translate(v = [0, 0, -sideWallConnLugDepression])
    cube(size = [sideWallConnW, sideWallConnD, sideWallConnLugDepression]);

    translate(v = [yBarScrewHoleToOuterYEdge, yBarScrewHoleToFrontXEdge, -(m3HeatSetInsertSlotHeightSlacked+sideWallConnLugDepression)])
    heatSetInsertSlot_N(rackFrameScrewType);
}

module sideWallConnectorMagnet() {
    difference() {
        cube(size = [sideWallConnW, sideWallConnD, sideWallConnLugDepression]);

        translate(v = [yBarScrewHoleToOuterYEdge, yBarScrewHoleToFrontXEdge, sideWallConnLugDepression])
        counterSunkHead_N(rackFrameScrewType, headExtension=eps,screwExtension=inf10);
    }

    translate(v = [0, 5, 6])
    rotate(a = [0, 90, 0])
    difference() {

        hull() {
            cylinder(r = magnetRSlacked + 1, h = magnetHSlacked+1);
            translate(v=[5,0,(magnetHSlacked+1)/2])
            cube(size=[eps, 2*(magnetRSlacked+1),magnetHSlacked+1], center=true);
        }
        translate(v=[0,0,1])
        cylinder(r = magnetRSlacked, h = magnetHSlacked);
    }

    //cylinder(r = magnetRSlacked, h = magnetHSlacked);
}

module sideWallConnectorHinge() {

}

module sideWallConnectorHinge_N() {

}


*sideWallConnector_N();

sideWallConnectorMagnet();

//counterSunkHead_N(rackFrameScrewType,screwExtension=10);
