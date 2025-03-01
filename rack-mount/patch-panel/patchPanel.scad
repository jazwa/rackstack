include <../common.scad>
use <../plateBase.scad>

/*
  Parametric patch panel -
  Please see ./entry.scad for configuring/printing

  Please also make sure that the correct rack frame preset is set in rackFrame.scad.
*/

module patchPanel(slots = 8, plateThickness = 3, screwToXEdge = 4.5, screwToYEdge = 4.5, keystoneSpacing = 19, center = false) {
    slotsWidth = slots * keystoneSpacing;
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

    for(i = [0 : slots - 1]) {
        translate([leftRailScrewToSlots + keystoneSpacing / 2 + i * keystoneSpacing, uDiff, -plateThickness])
        keystone(outerWidth = keystoneSpacing, outerHeight = plateHeight);
    }
}
