include <../config/common.scad>

//   These all constants are obtained by measuring rj45 keystone modules
// in hand. frontToRearDepth and rearPanelThickness are adjusted after testing.
// Before printing the Patch Panel, print a keystone(outerWidth = 19,
// outerHeight = 27) to test if it fits.
frontWidth = 14.5;
frontHeight = 16.2;

frontToRearDepth = 8.2 + 0.2; // Slack

rearWidth = frontWidth;
rearHeight = 19.55;
rearPanelThickness = 1.5; // Should be 2, set to 1.5 because of supporting

maximumWidth = frontWidth;
maximumHeight = 22.15;

module keystone(plateThickness = 1, outerWidth, outerHeight) {
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
        translate([-(maximumWidth + xySlack) / 2, -(outerHeight + 10) / 2, plateThickness])
        cube([rearWidth + xySlack, outerHeight + 20, frontToRearDepth - plateThickness]);

        // Rear panel hole
        translate([-(rearWidth + xySlack) / 2, -(frontHeight + xySlack) / 2, frontToRearDepth])
        cube([rearWidth + xySlack, rearHeight + xySlack, rearPanelThickness]);
    }
}

