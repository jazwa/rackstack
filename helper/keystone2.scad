include <../config/common.scad>

//   These all constants are obtained by measuring rj45 keystone modules
// in hand. frontToRearDepth and rearPanelThickness are adjusted after testing.
// Before printing the Patch Panel, print a keystone2(outerWidth = 19,
// outerHeight = 27) to test if it fits.
frontWidth = 14.5;
frontHeight = 16.2;

frontToRearDepth = 8.4;

rearWidth = frontWidth;
rearHeight = 19.55;
rearPanelThickness = 2 - supportedOverhangSlack;

maximumWidth = frontWidth;
maximumHeight = 22.15;

lugHeight = 1.3;

module keystone2(plateThickness = 1, outerWidth, outerHeight) {
    assert(outerWidth > maximumWidth);
    assert(outerHeight > maximumHeight);

    difference() {
        // Outer cube
        translate([-outerWidth / 2, -outerHeight / 2, 0])
        cube([outerWidth, outerHeight, frontToRearDepth + rearPanelThickness]);

        // Front panel hole
        translate([-(frontWidth + xySlack) / 2, -(frontHeight + xySlack) / 2, 0])
        cube([frontWidth + xySlack, frontHeight + xySlack, plateThickness]);

        // Middle cavity
        translate([-(maximumWidth + xySlack) / 2, -frontHeight / 2 - lugHeight - xySlack / 2, plateThickness])
        cube([rearWidth + xySlack, outerHeight + 1000, frontToRearDepth - plateThickness]);

        // Rear panel hole
        translate([-(rearWidth + xySlack) / 2, -(frontHeight + xySlack) / 2, frontToRearDepth])
        cube([rearWidth + xySlack, rearHeight + xySlack, rearPanelThickness]);
    }
}
