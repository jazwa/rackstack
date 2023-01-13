include <../helper/sphericalFilet.scad>
include <../helper/cylindricalFilet.scad>
include <../helper/screws.scad>
include <./config.scad>
include <./derivedConfig.scad>
include <./xyBarConnector.scad>

// Temporary
include <./yBar.scad>
include <./mainRail.scad>

xBarDepth = maxUnitWidth - 2*(railSlotSpacing + railScrewHoleToInnerEdge);

xBarWidth = 32;
xBarHeight = 15;

xBarWallThickness = 2;
xBarRoundness = baseRoundness;

//echo(xBarDepth);

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

    module mirrorOtherCorner() {
      children(0);

      // TODO rename xBarDepth to xBarLength/xBarWidth
      translate(v = [xBarDepth, 0, 0])
      mirror(v = [1, 0, 0]) {
        children(0);
      }
    }

    // TODO refactor - probably better off mirroring the side faces and hulling the shell
    difference() {
      union() {
        intersection() {
          positive();
          halfspace(vpos = [1, 0, 1], p = [0.5, 0, 0]);

          halfspace(vpos = [-1, 0, 1], p = [xBarDepth-0.5, 0, 0]);
        }

        yBarConnectorFromXLug();

        mirrorOtherCorner()
        yBarConnectorFromXLug();
      }

      union() {
        yBarConnectorFromX_N();

        mirrorOtherCorner()
        yBarConnectorFromX_N();
      }
    }
  }
  xBar();
}

xBar();


