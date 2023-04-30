include <../helper/math.scad>
include <../helper/matrix.scad>
include <../helper/sphericalFilet.scad>
include <../helper/cylindricalFilet.scad>
include <../helper/screws.scad>
include <../helper/magnet.scad>
include <./config.scad>
include <./mainRail.scad>

include <./connector/connectors.scad>

// Connectors
include <./side/yBarSideWallConnector.scad>
include <./sharedVariables.scad>

*yBar();

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
        cylindricalFiletEdge(yBarWidth, yBarDepth-2*joinCornerDepth, yBarHeight, yBarRoundness);
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

yBarMirrorOtherCornerTrans = translate(v = [0, yBarDepth, 0]) * mirror(v = [0, 1, 0]);

yBarBasePlateConnectorTrans = translate(v = [yBarWidth-yBarBasePlateConnectorWidth, joinCornerDepth, 0]);

yBarStackConnectorTrans = translate(v = [connectorXEdgeToYBarXEdge, connectorYEdgeToYBarYEdge, 0]);

yBarSideModuleConnectorTrans = translate(v = [
    yBarWidth-(railTotalWidth+railSlotToInnerYEdge+railSlotToSideWallSlot+sideWallConnectorSlotWidth),
  sideWallSlotToXZ,
  yBarHeight]);

yBarMainRailConnectorTrans = translate(v = [
    yBarWidth-(railTotalWidth+railSlotToInnerYEdge),
  railSlotToXZ,
    yBarHeight-railFootThickness]);

yBarXBarConnectorTrans = translate(v = [yBarWidth+eps, 0, 0]);
