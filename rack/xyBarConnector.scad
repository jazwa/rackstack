include <../helper/screws.scad>
include <../helper/dovetail.scad>
include <../helper/halfspace.scad>
include <./config.scad>

//xBarConnectorFromY_N();

module xBarConnectorFromY_N() {
    y = 27;
    z = 6;
    translate(v = [-m3HeatSetInsertSlotHeightSlacked, y, z])
    rotate(a = [0, 90, 0])
    heatSetInsertSlot_N(rackFrameScrewType);

}

module xBarConnectorFromY_P() {
    rotate(a=[0,0,-90])
    dovetail(topWidth = 15, bottomWidth = 12, height = 2, length = yBarHeight, headExtension = 1, baseExtension = 2, frontFaceLength = 0.5,
    frontFaceScale = 0.90,
    backFaceLength = 5,
    backFaceScale = 1.2);
}


module yBarConnectorFromX_N() {
    y = 27;
    z = 6;
    slack = 0.3;


    translate(v=[-0.5,14,0])
    mirror(v=[1,0,0])
    rotate(a=[0,0,-90])
    dovetail(topWidth = 15+slack, bottomWidth = 12+slack, height = 2+slack, length = yBarHeight, headExtension = 1, baseExtension = 2, frontFaceLength = 0.5,
    frontFaceScale = 1.1,
    backFaceLength = 5,
    backFaceScale = 1.2);

    translate(v = [-inf50/2, y, z])
    rotate(a = [0, 90, 0])
    cylinder(r = screwRadiusSlacked(rackFrameScrewType), h = inf50, $fn = 32);
}