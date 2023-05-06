include <../helper/math.scad>
include <./config.scad>
include <./mainRail.scad>
include <./yBar.scad>
include <./xBar.scad>


assemblyInstructions();

module assemblyInstructions () {

  screwXBarAndYBar();

  xBarSpaceToYBarSpace =
      yBarXBarConnectorTrans*
      xBarConnectorToYBarConnectorTrans*
    inv4x4(xBarYBarConnectorTrans);

  yBarSpaceToXBarSpace =
      xBarYBarConnectorTrans*
      yBarConnectorToXBarConnectorTrans*
    inv4x4(yBarXBarConnectorTrans);

  module xyTray() {
    yBar();

    multmatrix(xBarSpaceToYBarSpace*xBarMirrorOtherCornerTrans*yBarSpaceToXBarSpace)
    yBar();

    multmatrix(xBarSpaceToYBarSpace)
    xBar();

    multmatrix(yBarMirrorOtherCornerTrans*xBarSpaceToYBarSpace)
    xBar();
  }


  module caseScrewA() {
    color([0,1,1]) {
      difference() {
        scale(v = [0.9, 0.9, 0.9])
        counterSunkHead_N(rackFrameScrewType, screwExtension = 6, headExtension = 0.5);

        cylinder($fn = 6, r = 1.5);
      }
    }
  }

  module caseScrewB() {
    color([0,1,1]) {
      difference() {
        scale(v = [0.9, 0.9, 0.9])
        counterSunkHead_N(rackFrameScrewType, screwExtension = 10, headExtension = 0.5);

        cylinder($fn = 6, r = 1.5);
      }
    }
  }

  module arrow(length) {
    color([1,0,1]) {
      translate(v = [0, 0, length-2])
      cylinder(r1 = 2, r2 = 0.2, h = 2);

      cylinder(r = 1, h = length-2);
    }
  }

  module attachXBarWithYBar() {
    // assemble x-y bar trays
    multmatrix(translate(v = [0, 0, 20]))
    yBar();

    multmatrix(translate(v = [0, 0, 20])*xBarSpaceToYBarSpace*xBarMirrorOtherCornerTrans*yBarSpaceToXBarSpace)
    yBar();

    multmatrix(xBarSpaceToYBarSpace)
    xBar();

    multmatrix(yBarMirrorOtherCornerTrans*xBarSpaceToYBarSpace)
    xBar();
  }


  module screwXBarAndYBar(screwExtension=13) {

    // in x bar space
    function xBarYBarScrewTrans(extension) =
      translate(v=[27,xBarSideThickness + extension,6]) * rotate(a=[270,0,0]);

    // screw to connect x and y bars
    yBar();

    multmatrix(xBarSpaceToYBarSpace*xBarMirrorOtherCornerTrans*yBarSpaceToXBarSpace)
    yBar();

    multmatrix(xBarSpaceToYBarSpace)
    union() {
      xBar();

      multmatrix(xBarYBarScrewTrans(screwExtension))
      caseScrewB();

      multmatrix(xBarMirrorOtherCornerTrans * xBarYBarScrewTrans(screwExtension))
      caseScrewB();
    }

    multmatrix(yBarMirrorOtherCornerTrans*xBarSpaceToYBarSpace)
    union() {
      xBar();

      multmatrix(xBarYBarScrewTrans(screwExtension))
      caseScrewB();

      multmatrix(xBarMirrorOtherCornerTrans * xBarYBarScrewTrans(screwExtension))
      caseScrewB();
    }
  }


  module attachSideConnectorModulesToYBars() {
    // attach side connector modules to y bars

  }


  module insertDowelsIntoSideWall() {

  }

  module connectXYTraysWithMainRailAndSideWall() {

  }

  module screwMainRailAndYBar() {

  }


  module attachFeet() {

  }

  module attachTops() {

  }

}