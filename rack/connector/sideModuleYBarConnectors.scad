include <../../helper/screws.scad>
include <../../helper/common.scad>
include <../../helper/matrix.scad>
include <../../helper/slack.scad>
include <../../helper/dovetail.scad>
include <../../helper/halfspace.scad>

include <../sharedVariables.scad>

include <../config.scad>

module onYBarSideModuleNegative() {

  translate(v = [-xySlack/2, -xySlack/2, -sideWallConnLugDepression])
  cube(size = [sideWallConnW+xySlack, sideWallConnD+xySlack, sideWallConnLugDepression]);

  translate(v = [yBarScrewHoleToOuterYEdge, yBarScrewHoleToFrontXEdge, -(m3HeatSetInsertSlotHeightSlacked+sideWallConnLugDepression)])
  heatSetInsertSlot_N(rackFrameScrewType);
}