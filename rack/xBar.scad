include <../helper/cylindricalFilet.scad>
include <../helper/screws.scad>
include <./config.scad>
include <./xyBarConnector.scad>
include <./sharedVariables.scad>
// Temporary
include <./yBar.scad>

*xBar();

module xBar() {

  applyYBarConnector()
  xBarBase();

  module xBarBase() {
    intersection() {

      difference() {
        cylindricalFiletEdge(xBarY, xBarX, xBarHeight, xBarRoundness);

        translate(v = [xBarWallThickness, xBarSideThickness, xBarWallThickness])
        cylindricalFiletEdge(xBarY, xBarX-2*xBarSideThickness, xBarHeight, xBarRoundness);
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
    apply_n() {

      mirrorOtherCorner()
      rotate(a=[0,0,-90])
      yBarConnectorFromX_N();

      children(0);
    }
  }

}