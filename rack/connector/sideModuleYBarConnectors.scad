include <../../helper/screws.scad>
include <../../helper/common.scad>
include <../../helper/matrix.scad>
include <../../helper/slack.scad>
include <../../helper/dovetail.scad>
include <../../helper/halfspace.scad>
include <../sharedVariables.scad>
include <../side/sideWallVariables.scad>
include <../config.scad>

module onYBarSideModuleNegative() {

  translate(v = [-xySlack/2, -xySlack/2, -sideWallConnLugDepression])
  cube(size = [sideWallConnW+xySlack, sideWallConnD+xySlack, sideWallConnLugDepression]);

  translate(v = [yBarScrewHoleToOuterYEdge, yBarScrewHoleToFrontXEdge, -(4+sideWallConnLugDepression)])
  rotate(a=[0,0,90])
  hexNutPocket_N("m3", openSide=false, backSpace=5, bridgeFront=true);
}