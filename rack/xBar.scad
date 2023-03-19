include <../helper/cylindricalFilet.scad>
include <../helper/screws.scad>
include <./config.scad>
include <./xyBarConnector.scad>

// Temporary
include <./yBar.scad>

// It's actually the railSlotToInnerYEdge of the yBar, it'll be nice to be able to refer to it like yBar.railSlotToInnerYEdge
xBarX = maxUnitWidth - 2*railSlotToInnerYEdge;
xBarY = 32;
xBarHeight = 15;

xBarWallThickness = 2;
xBarRoundness = baseRoundness;

*xBar();

module xBar() {

  applyYBarConnector()
  xBarBase();

  module xBarBase() {
    intersection() {

      difference() {
        cylindricalFiletEdge(xBarY, xBarX, xBarHeight, xBarRoundness);

        translate(v = [xBarWallThickness, xBarWallThickness, xBarWallThickness])
        cylindricalFiletEdge(xBarY, xBarX-2*xBarWallThickness, xBarHeight, xBarRoundness);
      }

      // Shave off bottom corners to reduce elephant's foot at where xBar and YBar join
      halfspace(vpos = [0, 1, 1], p = [0, 0.75, 0]);
      halfspace(vpos = [0, -1, 1], p = [0, xBarX-0.75, 0]);
    }
  }

  module mirrorOtherCorner() {
    children(0);

    translate(v = [0, xBarX, 0])
    mirror(v = [0, 1, 0]) {
      children(0);
    }
  }

  module applyYBarConnector() {
    apply_pn() {

      mirrorOtherCorner()
      rotate(a=[0,0,-90])
      yBarConnectorFromXLug();

      mirrorOtherCorner()
      rotate(a=[0,0,-90])
      yBarConnectorFromX_N();

      children(0);
    }
  }

}