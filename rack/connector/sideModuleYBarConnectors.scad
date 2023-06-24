include <../../helper/common.scad>
include <../../config/common.scad>
include <../sharedVariables.scad>
include <../side/sideWallVariables.scad>

module onYBarSideModuleNegative() {

  translate(v = [-xySlack/2, -xySlack/2, -sideWallConnLugDepression])
  cube(size = [sideWallConnW+xySlack, sideWallConnD+xySlack, sideWallConnLugDepression]);

  translate(v = [yBarScrewHoleToOuterYEdge, yBarScrewHoleToFrontXEdge, -(4+sideWallConnLugDepression)])
  rotate(a=[0,0,90])
  hexNutPocket_N("m3", openSide=false, backSpace=5, bridgeFront=true);
}