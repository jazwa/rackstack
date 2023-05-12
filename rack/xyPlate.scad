include <../helper/slack.scad>
include <./yBar.scad>
include <./xBar.scad>
include <./connector/connectors.scad>

*xyPlate();


xyPlateConnDx = xBarX + 2*_heatSetX; // X distance between connectors
xyPlateConnDy = yBarDepth - 2*basePlateScrewMountToYBarXZFace; // Y distance between connectors

module xyPlate() {

  translate(v=-[connPosX,connPosY,0]) // center around one of the YBarConnector holes
  applyYBarConnectors()
  plateBody();

  connYBarCornerDx = yBarWidth; // distance from a plate body corner and the nearest yBar corner
  connYBarCornerDy = xBarY; // distance from a plate body corner and the nearest yBar corner

  connPosX = basePlateScrewMountToYBarYZFace - connYBarCornerDx; // distance between plateBody corner at (0,0,0) and the related corner
  connPosY = basePlateScrewMountToYBarXZFace - connYBarCornerDy;

  module plateBody() {
    plateBodyX = xBarX - xySlack;
    plateBodyY = (yBarDepth - 2*xBarY) - xySlack;
    plateBodyH = xBarWallThickness;

    translate(v=[xySlack/2, xySlack/2, 0])
    cube(size=[plateBodyX, plateBodyY, plateBodyH]);
  }

  module applyYBarConnectors() {

    // TODO ren
    echo("connPosX", connPosX);
    echo("connPosY", connPosY);

    apply_p() {
      union() {
        translate(v=[connPosX, connPosY, 0])
        yBarConnector();

        translate(v=[connPosX, connPosY+xyPlateConnDy, 0])
        yBarConnector();

        translate(v=[connPosX+xyPlateConnDx, connPosY, 0])
        rotate(a=[0,0,180])
        yBarConnector();

        translate(v=[connPosX+xyPlateConnDx, connPosY+xyPlateConnDy, 0])
        rotate(a=[0,0,180])
        yBarConnector();

      }

      children(0);
    }

    module yBarConnector() {
      difference() {
        hull() {
          translate(v=[0,0,_baseConnRecession])
          roundCutSlice(radius = heatSetInsertSlotRadiusSlacked(rackFrameScrewType), length=5);
          roundCutSlice(radius = _baseConnY/2, length=15);
        }

        cylinder(r=screwRadiusSlacked(rackFrameScrewType), h=inf, center=true);

      }
    }

  }
}