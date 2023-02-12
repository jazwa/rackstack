include <../helper/cylindricalFilet.scad>
include <../helper/screws.scad>
include <./config.scad>
include <./xyBarConnector.scad>

// Temporary
include <./yBar.scad>

// It's actually the railSlotToInnerYEdge of the yBar, it'll be nice to be able to refer to it like yBar.railSlotToInnerYEdge
xBarDepth = maxUnitWidth - 2*railSlotToInnerYEdge;

xBarWidth = 32;
xBarHeight = 15;

xBarWallThickness = 2;
xBarRoundness = baseRoundness;

*xBar();

module xBar() {

  applyYBarConnector()
  xBarBase();

  module xBarBase() {
    intersection() {
      mirror(v = [0, 1, 0])
      rotate(a = [0, 0, -90])
      difference() {
        cylindricalFiletEdge(xBarWidth, xBarDepth, xBarHeight, xBarRoundness);

        translate(v = [xBarWallThickness, xBarWallThickness, xBarWallThickness])
        cylindricalFiletEdge(xBarWidth, xBarDepth-2*xBarWallThickness, xBarHeight, xBarRoundness);
      }

      // Shave off bottom corners to reduce elephant's foot at where xBar and YBar join
      halfspace(vpos = [1, 0, 1], p = [0.6, 0, 0]);
      halfspace(vpos = [-1, 0, 1], p = [xBarDepth-0.6, 0, 0]);
    }
  }

  module mirrorOtherCorner() {
    children(0);

    // TODO rename xBarDepth to xBarLength/xBarWidth
    translate(v = [xBarDepth, 0, 0])
    mirror(v = [1, 0, 0]) {
      children(0);
    }
  }

  module applyYBarConnector() {
    apply_pn() {

      mirrorOtherCorner()
      yBarConnectorFromXLug();

      mirrorOtherCorner()
      yBarConnectorFromX_N();

      children(0);
    }
  }

}