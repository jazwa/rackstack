include <../helper/common.scad>
include <./connector/connectors.scad>

xyPlate();

module xyPlate() {

  translate(v=-[basePlateConnPosX,basePlateConnPosY,0]) // center around one of the YBarConnector holes
  applyVentilation()
  applyConnector(on="basePlate", to="yBar")
  plateBody();

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

}