include <../../helper/common.scad>
include <../../config/common.scad>
include <../sharedVariables.scad>

// Y-bar
yBarMirrorOtherCornerTrans = translate(v = [0, yBarDepth, 0]) * mirror(v = [0, 1, 0]);

yBarBasePlateConnectorTrans = translate(v = [yBarWidth-yBarBasePlateConnectorWidth, joinCornerDepth, 0]);

yBarStackConnectorTrans = translate(v = [connectorXEdgeToYBarXEdge, connectorYEdgeToYBarYEdge, 0]);

yBarSideModuleConnectorTrans = translate(v = [
    yBarWidth-(railTotalWidth+railSlotToInnerYEdge+railSlotToSideWallSlot+sideWallConnectorSlotWidth),
  sideWallSlotToXZ,
  yBarHeight
  ]);

yBarMainRailConnectorTrans = translate(v = [
    yBarWidth-(railTotalWidth+railSlotToInnerYEdge),
  railSlotToXZ,
    yBarHeight-railFootThickness
  ]);

yBarXBarConnectorTrans = translate(v = [yBarWidth+eps, 0, 0]);


// X-bar
xBarYBarConnectorTrans = rotate(a=[0,0,-90]);
xBarMirrorOtherCornerTrans = translate(v = [0, xBarX, 0]) * mirror(v = [0, 1, 0]);


// Main rail
mirrorMainRailOtherSideTrans = translate(v = [0, 0, railTotalHeight]) * mirror(v=[0,0,1]);

