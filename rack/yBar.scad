include <../helper/common.scad>
include <../config/common.scad>
include <./connector/connectors.scad>
include <./sharedVariables.scad>

yBar();

module yBar() {

  applyOnYBarBothCorners(to="basePlate", trans=yBarBasePlateConnectorTrans)
  applyOnYBarBothCorners(to="stackConnector", trans=yBarStackConnectorTrans)
  applyOnYBarBothCorners(to="sideModule", trans=yBarSideModuleConnectorTrans)
  applyOnYBarBothCorners(to="mainRail", trans=yBarMainRailConnectorTrans)
  applyOnYBarBothCorners(to="xBar", trans=yBarXBarConnectorTrans)
  yBarBase();

  module yBarBase() {
    intersection() {
      difference() {
        sphericalFiletEdge(yBarWidth, yBarDepth, yBarHeight, yBarRoundness);

        translate(v = [yBarWallThickness, joinCornerDepth, yBarWallThickness])
        cylindricalFiletEdge(yBarWidth, yBarDepth-2*joinCornerDepth, yBarHeight, yBarRoundness-yBarWallThickness);
      }

      halfspace(vpos=[-1, 0, 1], p=[yBarWidth-1, 0,0]);
    }
  }

  // Helper module to apply connectors to both corners
  module applyOnYBarBothCorners(to, trans) {
    applyConnector(on="yBar", to=to, trans=trans)
    applyConnector(on="yBar", to=to, trans=yBarMirrorOtherCornerTrans * trans)
    children(0);
  }
}
