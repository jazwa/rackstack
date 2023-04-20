
include <../config.scad>
include <../../helper/slack.scad>
include <./sideWallVariables.scad>
include <../sharedVariables.scad>

module yBarSideWallConnector_N() {
  translate(v = [-xySlack/2, -xySlack/2, -sideWallConnLugDepression])
  cube(size = [sideWallConnW+xySlack, sideWallConnD+xySlack, sideWallConnLugDepression]);

  translate(v = [yBarScrewHoleToOuterYEdge, yBarScrewHoleToFrontXEdge, -(m3HeatSetInsertSlotHeightSlacked+sideWallConnLugDepression)])
  heatSetInsertSlot_N(rackFrameScrewType);
}
