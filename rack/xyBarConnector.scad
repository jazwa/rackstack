include <./config.scad>
include <./screws.scad>

module frontBarConnector_N() {

    y1 = 6;
    y2 = 27;
    z = 6;

    translate(v = [-m3HeatSetInsertSlotHeightSlacked, y1, z])
        rotate(a = [0, 90, 0])
            heatSetInsertSlot_N(rackFrameScrewType);

    translate(v = [-m3HeatSetInsertSlotHeightSlacked, y2, z])
        rotate(a = [0, 90, 0])
            heatSetInsertSlot_N(rackFrameScrewType);

    // TODO fix this up, no center=true
    translate(v = [-1, y1+(y2-y1)/2, 0])
        rotate(a = [0, 45, 0])
            cube(size = [3, 10, 6], center = true);
}