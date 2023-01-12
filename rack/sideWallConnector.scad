include <./config.scad>
include <./screws.scad>

module sideWallConnector_N() {

    lugW = 7;
    lugD = 20;
    lugH = 2;

    insertDw = lugW/2;

    insertDd = lugD-4;

    translate(v = [0, 0, -lugH])
        cube(size = [lugW, lugD, lugH]);

    translate(v = [insertDw, insertDd, -(m3HeatSetInsertSlotHeightSlacked+lugH)])
        heatSetInsertSlot_N(rackFrameScrewType);
}