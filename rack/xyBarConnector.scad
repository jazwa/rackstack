include <../helper/screws.scad>
include <../helper/dovetail.scad>
include <../helper/halfspace.scad>
include <./config.scad>

module xBarConnectorFromY_N() {
    y = 27;
    z = 6;
    translate(v = [-m3HeatSetInsertSlotHeightSlacked, y, z])
    rotate(a = [0, 90, 0])
    heatSetInsertSlot_N(rackFrameScrewType);

}

module xBarConnectorFromY_P() {
    rotate(a=[0,0,-90])
    dovetail(topWidth = 15, bottomWidth = 12, height = 2, length = yBarHeight, headExtension = 1, baseExtension = 2, frontFaceLength = 2,
    frontFaceScale = 0.85,
    backFaceLength = 5,
    backFaceScale = 1.2);
}


module yBarConnectorFromX_N() {
    y = 27;
    z = 6;
    slack = 0.4;

    translate(v=[-0.5,14,0])
    mirror(v=[1,0,0])
    rotate(a=[0,0,-90])
    dovetail(topWidth = 15+slack, bottomWidth = 12+slack, height = 2+slack, length = yBarHeight, headExtension = 1, baseExtension = 2, frontFaceLength = 0.5,
    frontFaceScale = 1.1,
    backFaceLength = 5,
    backFaceScale = 1.3);

    // TODO clean this up
    translate(v = [-6, y, z])
    rotate(a = [0, -90, 0])
    counterSunkHead_N(rackFrameScrewType, screwExtension=inf10, headExtension=inf10);
}

