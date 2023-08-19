include <../../helper/common.scad>
include <../../config/common.scad>
include <../sharedVariables.scad>

connectorTopThickness = screwRadiusSlacked(rackFrameScrewType)+0.5;

module onYBarBasePlateConnectorPositive() {
  translate(v=[0,0,yBarWallThickness])
  intersection() {
    cube(size = [yBarXYPlateBlockX, yBarXYPlateBlockY, yBarXYPlateBlockZ]);
    halfspace(vpos=[0, -1, -1], p=[0, yBarXYPlateBlockY-1, yBarXYPlateBlockZ-1]);
  }
}

module onYBarBasePlateConnectorNegative() {

  translate(v=[basePlateYBarSlideNutDx, basePlateYBarSlideNutDy, 4 + plateBlockBaseConnRecession])
  mirror(v=[0,0,1])
  hexNutPocket_N("m3", openSide=false, backSpace=5, bridgeBack=true);

  hull() {
    // This has always been a pretty annoying to fit part. Increasing slack to 2*radiusXYSlack to compensate. TODO fix
    translate(v = [basePlateYBarSlideNutDx, basePlateYBarSlideNutDy, plateBlockBaseConnRecession+overhangSlack])
    roundCutSlice(radius = connectorTopThickness+2*radiusXYSlack);

    translate(v = [basePlateYBarSlideNutDx, basePlateYBarSlideNutDy, 0])
    roundCutSlice(radius = plateBlockBaseConnY/2 + 2*radiusXYSlack);
  }

}

module onBasePlateToYBarConnectorPositive() {

  union() {
    translate(v=[basePlateConnPosX, basePlateConnPosY, 0])
      yBarConnector();

    translate(v=[basePlateConnPosX, basePlateConnPosY+xyPlateConnDy, 0])
      yBarConnector();

    translate(v=[basePlateConnPosX+xyPlateConnDx, basePlateConnPosY, 0])
      rotate(a=[0,0,180])
        yBarConnector();

    translate(v=[basePlateConnPosX+xyPlateConnDx, basePlateConnPosY+xyPlateConnDy, 0])
      rotate(a=[0,0,180])
        yBarConnector();

  }

  module yBarConnector() {
    difference() {
      hull() {
        translate(v=[0,0,plateBlockBaseConnRecession])
        roundCutSlice(radius = connectorTopThickness, length=5);

        roundCutSlice(radius = plateBlockBaseConnY/2, length=15);
      }
      mirror(v=[0,0,1])
        counterSunkHead_N(rackFrameScrewType, headExtension = eps, screwExtension = inf10);

    }
  }
}

module roundCutSlice(radius, length=inf50) {

  hull() {
    cylinder(r = radius, h = eps);

    translate(v = [length, -radius, 0])
    cube(size = [eps, radius*2, eps]);
  }
}