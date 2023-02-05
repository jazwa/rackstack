
include <../config.scad>
include <./sideWallVariables.scad>
include <../sharedVariables.scad>


module yBarSideWallConnector_N() {
  translate(v = [0, 0, -sideWallConnLugDepression])
  cube(size = [sideWallConnW, sideWallConnD, sideWallConnLugDepression]);

  translate(v = [yBarScrewHoleToOuterYEdge, yBarScrewHoleToFrontXEdge, -(m3HeatSetInsertSlotHeightSlacked+sideWallConnLugDepression)])
  heatSetInsertSlot_N(rackFrameScrewType);
}
