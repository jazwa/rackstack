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

railSlotToInnerYEdge = 2;
railSlotToXZ = 3;
railSlotToSideWallSlot = 0;
sideWallSlotToOuterYEdge = 3;
sideWallSlotToXZ = 3;

yBarDepth = maxUnitDepth + 2*railSlotToInnerYEdge;
yBarWidth = railSlotToInnerYEdge + railTotalWidth+ railSlotToSideWallSlot
  + sideWallSlotToOuterYEdge + sideWallConnectorSlotWidth;
yBarHeight = 15;
yBarWallThickness = 3;
yBarRoundness = baseRoundness;

joinCornerDepth = 32;

echo("Bar total depth: ", yBarDepth);
echo("Bar total width: ", yBarWidth);
echo("Bar total height: ", yBarHeight);

*yBar();

module yBar() {

  applyBasePlateConnector()
  applyStackConnector()
  applySideWallConnector()
  applyRailConnector()
  applyXBarConnector()
  yBarBase();

  module yBarBase() {
    intersection() {
      difference() {
        sphericalFiletEdge(yBarWidth, yBarDepth, yBarHeight, yBarRoundness);

        translate(v = [yBarWallThickness, joinCornerDepth, yBarWallThickness])
        cylindricalFiletEdge(yBarWidth, yBarDepth-2*joinCornerDepth, yBarHeight, yBarRoundness);
      }

      halfspace(vpos=[-1, 0, 1], p=[yBarWidth-0.5, 0,0]);
    }
  }

  module applyBasePlateConnector() {
    apply_pn() {
      mirrorOtherCorner() {
        translate(v = [yBarWidth-yBarBasePlateConnectorWidth, joinCornerDepth, yBarWallThickness])
        yBarBasePlateMount_P();
      }

      mirrorOtherCorner() {
        translate(v = [yBarWidth-yBarBasePlateConnectorWidth, joinCornerDepth, 0])
        yBarBasePlateMount_N();
      }

      children(0);
    }
  }

  module applyStackConnector() {
    apply_n() {
      mirrorOtherCorner()
      translate(v = [5, 5, 0])
      stackConnectorSocket_N();

      children(0);
    }
  }

  module applySideWallConnector() {
    apply_n() {
      mirrorOtherCorner()
      translate(v = [yBarWidth-(railTotalWidth+railSlotToInnerYEdge+railSlotToSideWallSlot+sideWallConnectorSlotWidth), sideWallSlotToXZ, yBarHeight])
      sideWallConnector_N();

      children(0);
    }
  }

  module applyRailConnector() {
    apply_n() {
      mirrorOtherCorner()
      translate(v = [yBarWidth-(railTotalWidth+railSlotToInnerYEdge), railSlotToXZ, yBarHeight-railFootThickness])
      railFeetSlot_N();

      children(0);
    }
  }

  module applyXBarConnector() {
    apply_n() {
      mirrorOtherCorner()
      translate(v = [yBarWidth+eps, 0, 0])
      xBarConnectorFromY_N();

      children(0);
    }
  }

  module mirrorOtherCorner() {
    children(0);

    translate(v = [0, yBarDepth, 0])
    mirror(v = [0, 1, 0])
    children(0);
  }

}
