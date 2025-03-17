include <../common.scad>
use <../plateBase.scad>

/*
  Parametric patch panel -
  Please see ./entry.scad for configuring/printing

  Please also make sure that the correct rack frame preset is set in rackFrame.scad.
*/

module patchPanel(slots, plateThickness = 3, screwToXEdge = 4.5, screwToYEdge = 4.5, keystoneSpacing = 19, center = false) {
    slotsWidth = len(slots) * keystoneSpacing;
    slotsMinPadding = railScrewHoleToInnerEdge+4;
    plateLength = rackMountScrewWidth + 2 * screwToXEdge;
    plateHeight = 2 * uDiff + 2 * screwToXEdge;
    leftRailScrewToSlots = center
            ? (plateLength-(slotsWidth+slotsMinPadding))/2
            : slotsMinPadding;

    difference() {
        plateBase(U =  2, plateThickness = plateThickness, screwType = mainRailScrewType, screwToXEdge = screwToXEdge, screwToYEdge = screwToYEdge, filletR = 2);
        translate([leftRailScrewToSlots, -screwToYEdge - 10 * eps, -plateThickness - 10 * eps])
        cube([slotsWidth, plateHeight + 2 * 10 * eps, plateThickness + 2 * 10 * eps]);
    }

    for(i = [0 : len(slots) - 1]) {
        translate([leftRailScrewToSlots + keystoneSpacing / 2 + i * keystoneSpacing, uDiff, -plateThickness])
        let (slot = slots[i])
        if (slot == 1) keystone1(outerWidth = keystoneSpacing, outerHeight = plateHeight);
        else if (slot == 2) keystone2(outerWidth = keystoneSpacing, outerHeight = plateHeight);
        else if (slot == 3) plate(outerWidth = keystoneSpacing, outerHeight = plateHeight, thickness = plateThickness);
        else if (slot == 4) plate(outerWidth = keystoneSpacing, outerHeight = plateHeight, thickness = 5.9);
        else if (slot == 5) plate(outerWidth = keystoneSpacing, outerHeight = plateHeight, thickness = 9.9);
        else assert(false);
    }
}

module plate(outerWidth, outerHeight, thickness) {
    translate([0, 0, thickness / 2])
    cube([outerWidth, outerHeight, thickness], center = true);
}
