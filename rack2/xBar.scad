include <../helper/sphericalFilet.scad>
include <../helper/cylindricalFilet.scad>
include <./config.scad>
include <./screws.scad>

xBarDepth = 180;
xBarWidth = 32;
xBarHeight = 15;

xBarWallThickness = 3;
xBarRoundness = 5;

module xBar() {

  module positive() {
    mirror(v=[0,1,0])
    rotate(a=[0,0,-90])
    difference() {
      cylindricalFiletEdge(xBarWidth, xBarDepth, xBarHeight, xBarRoundness);

      translate(v = [xBarWallThickness, xBarWallThickness, xBarWallThickness])
      cylindricalFiletEdge(xBarWidth, xBarDepth - 2*xBarWallThickness, xBarHeight, xBarRoundness);
    }
  }

  module xBar() {
    positive();
  }

  xBar();
}


//xBar();