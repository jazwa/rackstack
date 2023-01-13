include <../helper/screws.scad>
include <../helper/halfspace.scad>
include <./config.scad>

module xBarConnectorFromY_N() {
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


module yBarConnectorFromX_N() {
    y1 = 6;
    y2 = 27;
    z = 6;
    translate(v = [-inf50/2, y1, z])
    rotate(a = [0, 90, 0])
    cylinder(r = screwRadiusSlacked(rackFrameScrewType), h = inf50, $fn = 32);

    translate(v = [-inf50/2, y2, z])
    rotate(a = [0, 90, 0])
    cylinder(r = screwRadiusSlacked(rackFrameScrewType), h = inf50, $fn = 32);
}

// TODO: figure out nice abstraction to apply both positive and negative mods
module yBarConnectorFromXLug() {
    y1 = 6;
    y2 = 27;
    z = 6;

    intersection() {
        // TODO fix this up, no center=true
        translate(v = [-1, y1+(y2-y1)/2, 0])
        rotate(a = [0, 45, 0])
        scale(v=[0.90,0.95,0.90])
        cube(size = [3, 10, 6], center = true);

        mirror(v=[0,0,1])
        halfspace(vpos=[0,0,1], p=[0,0,0]);

        halfspace(vpos=[1,0,0], p=[-2,0,0]);
    }
}