include <./yBar.scad>
include <./xBar.scad>

xyPlate();

module xyPlate() {

  applyYBarConnectors()
  plateBody();

  module plateBody() {
    slack = 0.5;
    plateBodyX = xBarX - slack;
    plateBodyY = (yBarDepth - 2*xBarY) - slack;
    plateBodyH = xBarWallThickness;

    translate(v=[slack/2, slack/2, 0])
    cube(size=[plateBodyX, plateBodyY, plateBodyH]);
  }

  module applyYBarConnectors() {
    slack = 0.3;
    // TODO rename _heatSetX to something more indicative of yBarBasePlateConnector
    connDx = xBarX + 2*_heatSetX; // X distance between connectors
    connDy = yBarDepth - 2*basePlateScrewMountToYBarXZFace; // Y distance between connectors

    connYBarCornerDx = yBarWidth; // distance from a plate body corner and the nearest yBar corner
    connYBarCornerDy = xBarY; // distance from a plate body corner and the nearest yBar corner

    connPosX = basePlateScrewMountToYBarYZFace - connYBarCornerDx; // distance between plateBody corner at (0,0,0) and the related corner
    connPosY = basePlateScrewMountToYBarXZFace - connYBarCornerDy;


    apply_p() {
      union() {
        translate(v=[connPosX, connPosY, 0])
        yBarConnector();

        translate(v=[connPosX, connPosY+connDy, 0])
        yBarConnector();

        translate(v=[connPosX+connDx, connPosY, 0])
        rotate(a=[0,0,180])
        yBarConnector();

        translate(v=[connPosX+connDx, connPosY+connDy, 0])
        rotate(a=[0,0,180])
        yBarConnector();

      }

      children(0);
    }

    module yBarConnector() {
      difference() {
        hull() {
          cylinder(r = _baseConnY/2 - slack/2, h = _baseConnRecession);

          translate(v = [1-connPosX, -_baseConnY/2, 0])
          cube(size = [eps, _baseConnY-slack, _baseConnRecession]);

          translate(v = [5-connPosX, -_baseConnY/2, 0])
          cube(size = [eps, _baseConnY-slack, eps]);
        }

        cylinder(r=screwRadiusSlacked(rackFrameScrewType), h=inf, center=true);

      }
    }

  }
}