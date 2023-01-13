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
include <./yBarBasePlateConnector.scad>

// TODO clean up
// TODO: How do I nicely explain this?
railSlotSpacing = 3;
sideSpacing = 12;

yBarDepth = maxUnitDepth + 2*railSlotSpacing;
yBarWidth = railSlotSpacing + railTotalWidth + sideSpacing;
yBarHeight = 15;

yBarWallThickness = 3;
yBarRoundness = baseRoundness;

joinCornerDepth = 32;

echo("Bar total depth: ", yBarDepth);
echo("Bar total width: ", yBarWidth);


module yBar() {

  module positive() {
    difference() {
      sphericalFiletEdge(yBarWidth, yBarDepth, yBarHeight, yBarRoundness);

      translate(v = [yBarWallThickness, joinCornerDepth, yBarWallThickness])
      cylindricalFiletEdge(yBarWidth, yBarDepth-2*joinCornerDepth, yBarHeight, yBarRoundness);
    }
  }

  module singleCornerNoStackConnector_N() {
    union() {
      translate(v = [5, 5, 0])
      stackConnectorSocket_N();

      translate(v = [yBarWidth-(railTotalWidth+railSlotSpacing), railSlotSpacing, yBarHeight-railFootThickness])
      railFeetSlot_N();

      translate(v = [yBarWidth+eps, 0, 0])
      xBarConnectorFromY_N();

      translate(v = [yBarWidth-(railTotalWidth+railSlotSpacing)-9, railSlotSpacing, yBarHeight])
      sideWallConnector_N();
    }
  }

    module yBar() {

    module mirrorOtherCorner() {
      children(0);

      translate(v = [0, yBarDepth, 0])
      mirror(v = [0, 1, 0]) {
        children(0);
      }
    }

    difference() {

      union() {
        positive();

        mirrorOtherCorner()
        translate(v=[yBarWidth-12, joinCornerDepth,0.01])
        yBarBasePlateMount_P(mountX=12, mountZ=yBarHeight);
      }
      union() {
        mirrorOtherCorner()
        singleCornerNoStackConnector_N();

        mirrorOtherCorner()
        translate(v=[yBarWidth-12, joinCornerDepth, 0])
        yBarBasePlateMount_N();
      }
    }
  }

  yBar();
}

translate(v=[yBarWidth-12, joinCornerDepth, m3CounterSunkHeadLength])
*yBarBasePlateMount_N();
yBar();

//counterSunkHead_N("m3", 1, 1);