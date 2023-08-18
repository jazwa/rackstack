include <../helper/common.scad>
include <./connector/connectors.scad>

*xyPlate();

xyPlateConnDx = xBarX + 2*basePlateYBarSlideNutDx; // X distance between connectors
xyPlateConnDy = yBarDepth - 2*basePlateScrewMountToYBarXZFace; // Y distance between connectors

module xyPlate() {

  translate(v=-[connPosX,connPosY,0]) // center around one of the YBarConnector holes
  applyVentilation()
  applyYBarConnectors()
  plateBody();

  connYBarCornerDx = yBarWidth; // distance from a plate body corner and the nearest yBar corner
  connYBarCornerDy = xBarY; // distance from a plate body corner and the nearest yBar corner

  connPosX = basePlateScrewMountToYBarYZFace - connYBarCornerDx; // distance between plateBody corner at (0,0,0) and the related corner
  connPosY = basePlateScrewMountToYBarXZFace - connYBarCornerDy;

  module plateBody() {
    plateBodyX = xBarX - 2*plateGap;
    plateBodyY = (yBarDepth - 2*xBarY) - 2*plateGap;
    plateBodyH = xBarWallThickness;

    translate(v=[plateGap, plateGap, 0]) {
      cube(size = [plateBodyX, plateBodyY, plateBodyH]);

      // bracing
      braceThickness = 3;
      braceHeight = 2;
      translate(v = [0, 0, plateBodyH])
      difference() {
        cube(size = [plateBodyX, plateBodyY, braceHeight]);
        translate(v=[braceThickness, braceThickness,0])
        cube(size=[plateBodyX-2*braceThickness, plateBodyY-2*braceThickness, braceHeight]);
      }

    }
  }

  module applyVentilation() {

    apply_n() {
      numSlits = 5;
      edgePadding = 30;
      diff = (xBarX-2*edgePadding)/(numSlits-1);
      slitWidth = 4;
      slitLength = (yBarDepth - 2*xBarY)-2*edgePadding;

      for(i=[0:numSlits-1]) {
        translate(v=[edgePadding+diff*i-slitWidth/2, edgePadding,0])
        minkowski() {
          cylinder(h=1,r=2);
          cube(size=[slitWidth,slitLength,inf]);
        }
      }
      children(0);
    }
  }

  module applyYBarConnectors() {

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
          // TODO: we don't need to heatset insert values anymore
          translate(v=[0,0,_baseConnRecession])
          roundCutSlice(radius = heatSetInsertSlotRadiusSlacked(rackFrameScrewType), length=5);
          roundCutSlice(radius = _baseConnY/2, length=15);
        }
        mirror(v=[0,0,1])
        counterSunkHead_N(rackFrameScrewType, headExtension = eps, screwExtension = inf10);

      }
    }

  }
}