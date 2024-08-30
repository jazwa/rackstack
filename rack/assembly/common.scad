include <../../helper/common.scad>
include <../../config/common.scad>
include <../sharedVariables.scad>
include <../side/sideWallVariables.scad>
include <../connector/connectors.scad>
use <../mainRail.scad>
use <../yBar.scad>
use <../xBar.scad>
use <../side/magnetModule.scad>
use <../side/hingeModule.scad>
use <../side/sideWallRight.scad>
use <../side/sideWallLeft.scad>
use <../stackEnds.scad>
use <../xyPlate.scad>

screwMask = false;
plasticMask = false;
sideSupportRailMask = true;

xBarSpaceToYBarSpace =
    yBarXBarConnectorTrans *
    xBarConnectorToYBarConnectorTrans *
  inv4x4(xBarYBarConnectorTrans);

yBarSpaceToXBarSpace =
    xBarYBarConnectorTrans *
    yBarConnectorToXBarConnectorTrans *
  inv4x4(yBarXBarConnectorTrans);

upperXYTrayTrans =
    yBarMainRailConnectorTrans *
    mirrorMainRailOtherSideTrans *
  inv4x4(yBarMainRailConnectorTrans);

function feetToYBarTrans(t=0) =
    translate(v=[connectorRectWidth/2,connectorRectDepth/2,-t]) *
    yBarStackConnectorTrans *
  mirror(v=[0,1,0]);

function stackConnectorTrans(t=0) =
  upperXYTrayTrans *
  yBarStackConnectorTrans;

module mirrorAllTrayCornersFromYBarSpace() {
  children(0);

  multmatrix(yBarMirrorOtherCornerTrans)
    children(0);

  multmatrix(xBarSpaceToYBarSpace * xBarMirrorOtherCornerTrans * yBarSpaceToXBarSpace * yBarMirrorOtherCornerTrans)
    children(0);

  multmatrix(xBarSpaceToYBarSpace * xBarMirrorOtherCornerTrans * yBarSpaceToXBarSpace * yBarMirrorOtherCornerTrans * yBarMirrorOtherCornerTrans)
    children(0);
}

secondStackTrans = upperXYTrayTrans * mirror(v=[0,0,1]);



yBarToMagnetModuleTrans =
    translate(v=[13,0,sideWallConnLugDepression]) *
    inv4x4(yBarSideModuleConnectorTrans) *
    mirror(v=[1,0,0]);


module caseScrewShort() {
  if (!screwMask) {
    color([1, 1, 1]) {
      difference() {
        scale(v = [0.9, 0.9, 0.9])
          counterSunkHead_N(rackFrameScrewType, screwExtension = 8, headExtension = 0.5);

        cylinder($fn = 6, r = 1.5);
      }
    }
  }
}

module caseScrewMedium() {
  if (!screwMask) {
    color([1, 1, 1]) {
      difference() {
        scale(v = [0.9, 0.9, 0.9])
          counterSunkHead_N(rackFrameScrewType, screwExtension = 12, headExtension = 0.5);

        cylinder($fn = 6, r = 1.5);
      }
    }
  }
}

module caseScrewLong() {
  if (!screwMask) {
    color([1, 1, 1]) {
      difference() {
        scale(v = [0.9, 0.9, 0.9])
          counterSunkHead_N(rackFrameScrewType, screwExtension = 16, headExtension = 0.5);

        cylinder($fn = 6, r = 1.5);
      }
    }
  }
}

module hingeDowel() {
  if (!screwMask) {
    color([0, 1, 1])
      cylinder(h = dowelPinH, r = dowelPinR);
  }
}


module magnet() {
  if (!screwMask) {
    color([1, 1, 1])
      cylinder(r = magnetR, h = magnetH);
  }
}

module arrow(length) {
  color([1,0,1]) {
    translate(v = [0, 0, length-2])
      cylinder(r1 = 2, r2 = 0.2, h = 2);

    cylinder(r = 1, h = length-2);
  }
}
