include <../helper/math.scad>
include <../helper/sphericalFilet.scad>
include <../helper/cylindricalFilet.scad>
include <../helper/screws.scad>
include <../misc/magnet.scad>

include <./config.scad>
include <./mainRail.scad>

// Connectors
include <./stackConnector.scad>
include <./xyBarConnector.scad>
include <./sideWallConnector.scad>

// TODO clean up
// TODO: How do I nicely explain this?
railSlotSpacing = 3;
sideSpacing = 12;

yBarDepth = maxUnitDepth + 2*railSlotSpacing;
yBarWidth = railSlotSpacing + railTotalWidth + sideSpacing;
yBarHeight = 15;

yBarWallThickness = 3;
yBarRoundness = 5;

echo("Bar total depth: ", yBarDepth);
echo("Bar total width: ", yBarWidth);


module yBar() {

  module positive() {
    difference() {
      sphericalFiletEdge(yBarWidth, yBarDepth, yBarHeight, yBarRoundness);

      translate(v = [yBarWallThickness, 32, yBarWallThickness])
      cylindricalFiletEdge(yBarWidth, yBarDepth-32*2, yBarHeight, yBarRoundness);
    }
  }

  module singleCornerNoStackConnector_N() {
    union() {
      translate(v = [5, 5, 0])
      stackConnectorSocket_N();

      translate(v = [yBarWidth-(railTotalWidth+railSlotSpacing), railSlotSpacing, yBarHeight-railFootThickness])
      railFeetSlot_N();

      translate(v = [yBarWidth+eps, 0, 0])
      frontBarConnector_N();

      translate(v = [yBarWidth-(railTotalWidth+railSlotSpacing)-9, railSlotSpacing, yBarHeight])
      sideWallConnector_N();
    }
  }

  module sideBar() {

    module mirrorOtherCorner() {
      children(0);

      translate(v = [0, yBarDepth, 0])
      mirror(v = [0, 1, 0]) {
        children(0);
      }
    }

    difference() {
      positive();

      mirrorOtherCorner()
      singleCornerNoStackConnector_N();
    }
  }

  sideBar();
}
