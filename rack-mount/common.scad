
include <../rack/sharedVariables.scad>
include <../helper/common.scad>
include <../config/common.scad>

/*
  QoL redefinitions/variables/reimports for rack mount items
*/

uDiff = screwDiff;

rackMountScrewXDist = 4.5;
rackMountScrewZDist = 4.5;

mainRailSideSupportToInnerEdge = frontFaceWidth - railSideMountThickness;
railSupportsDx = 2*mainRailSideSupportToInnerEdge + maxUnitWidth;