include <../config/common.scad>
include <../helper/common.scad>
include <../rack/sharedVariables.scad>
use <./plateBase.scad>


patchPanel(slots=2);

module patchPanel (slots=8) {
    difference() {
        plateThickness = 3;
        keystoneSpacing = 19;
        supportPlateThickness = 5.9;
        supportPlateHeight = 29;
        supportPlateEdgeSpacing = 3;
        supportPlateWidth = slots * keystoneSpacing + supportPlateEdgeSpacing;

        leftRailScrewToSupportDx = railScrewHoleToInnerEdge+4;
        railScrewToEdge = 4.5;

        union() {
            plateBase(U = 2, plateThickness = plateThickness, screwType = mainRailScrewType,  screwToXEdge=railScrewToEdge, screwToYEdge=railScrewToEdge, filletR = 2);
            translate(v = [leftRailScrewToSupportDx, - railScrewToEdge, - supportPlateThickness])
            cube(size = [supportPlateWidth, supportPlateHeight, supportPlateThickness]);
        }

        union() {
            for (i = [0:slots-1]) {
                translate(v = [leftRailScrewToSupportDx+supportPlateEdgeSpacing + i*keystoneSpacing, 0, eps])
                rotate(a = [-90, 0, 0])
                rj45KeystoneJack_N();
            }
        }
    }
}