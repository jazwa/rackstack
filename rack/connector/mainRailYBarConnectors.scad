include <../../helper/screws.scad>
include <../../helper/common.scad>
include <../../helper/matrix.scad>
include <../../helper/slack.scad>
include <../../helper/dovetail.scad>
include <../../helper/halfspace.scad>

include <../sharedVariables.scad>

include <../config.scad>

module onYBarToMainRailNegative() {

  slotSlack = xySlack;
  slotZSlack = zSlack;

  union() {
    translate(v=[-slotZSlack/2, -slotSlack/2,0])
    cube(size = [railTotalWidth+slotZSlack, railTotalDepth + slotSlack, railFootThickness]);

    translate(v = [railSideMountThickness + 5, railFrontThickness + 4 , -m3HeatSetInsertSlotHeightSlacked])
    heatSetInsertSlot_N(rackFrameScrewType);
  }
}


module onMainRailYBarConnectorPositive() {

  cube(size = [frontFaceWidth, sideSupportDepth+railFrontThickness, railFootThickness]);
}


module onMainRailYBarConnectorNegative() {

  translate(v = [5+railSideMountThickness, 4+railFrontThickness, railFootThickness])
  counterSunkHead_N(rackFrameScrewType, screwExtension=inf10, headExtension=inf10);
}