include <../../helper/screws.scad>
include <../../helper/common.scad>
include <../../helper/matrix.scad>
include <../../helper/slack.scad>
include <../../helper/dovetail.scad>
include <../../helper/halfspace.scad>

include <../sharedVariables.scad>

include <../config.scad>

mainRailHeatSetOnYBarDx = railSideMountThickness + 5;
mainRailHeatSetOnYBarDy = railFrontThickness + 4;
module onYBarToMainRailNegative() {

  slotSlack = xySlack;
  slotZSlack = zSlack;

  union() {
    translate(v=[-slotZSlack/2, -slotSlack/2,0])
    cube(size = [railTotalWidth+slotZSlack, railTotalDepth + slotSlack, railFootThickness]);

    translate(v = [mainRailHeatSetOnYBarDx, mainRailHeatSetOnYBarDy, -m3HeatSetInsertSlotHeightSlacked])
    heatSetInsertSlot_N(rackFrameScrewType);
  }
}


module onMainRailYBarConnectorPositive() {

  cube(size = [frontFaceWidth, sideSupportDepth+railFrontThickness, railFootThickness]);
}


module onMainRailYBarConnectorNegative() {

  translate(v = [mainRailHeatSetOnYBarDx, mainRailHeatSetOnYBarDy, railFootThickness])
  counterSunkHead_N(rackFrameScrewType, screwExtension=inf10, headExtension=inf10);
}