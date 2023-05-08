include <../helper/math.scad>
include <./config.scad>
include <./mainRail.scad>
include <./yBar.scad>
include <./xBar.scad>
include <./side/magnetModule.scad>
include <./side/hingeModule.scad>

assemblyInstructions();

module assemblyInstructions () {

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



  module attachSideConnectorModulesToYBars(elevation=0) {
    // attach side connector modules to y bars

    screwXBarAndYBar(screwExtension=0);

    // side module to front corner ybar
    function sideModuleTrans(t=0) =
      translate(v=[sideWallConnW,0,t-sideWallConnLugDepression])
      * yBarSideModuleConnectorTrans
      * mirror(v=[1,0,0]); // mirror for magnetModule


    multmatrix(sideModuleTrans(elevation))
    union() {
      magnetModule();

      translate(v=[yBarScrewHoleToOuterYEdge,yBarScrewHoleToFrontXEdge,sideWallConnLugDepression + 2*elevation])
      caseScrewA();
    }

    multmatrix(xBarSpaceToYBarSpace * xBarMirrorOtherCornerTrans * yBarSpaceToXBarSpace * sideModuleTrans(elevation))
    union() {
      magnetModule();

      translate(v=[yBarScrewHoleToOuterYEdge,yBarScrewHoleToFrontXEdge,sideWallConnLugDepression + 2*elevation])
      caseScrewA();
    }

    multmatrix(yBarMirrorOtherCornerTrans * sideModuleTrans(elevation))
    union() {
      hingeModule();

      translate(v=[yBarScrewHoleToOuterYEdge,yBarScrewHoleToFrontXEdge,sideWallConnLugDepression + 2*elevation])
      caseScrewA();
    }

    multmatrix(xBarSpaceToYBarSpace * xBarMirrorOtherCornerTrans * yBarSpaceToXBarSpace * yBarMirrorOtherCornerTrans * sideModuleTrans(elevation))
    union() {
      hingeModule();

      translate(v=[yBarScrewHoleToOuterYEdge,yBarScrewHoleToFrontXEdge,sideWallConnLugDepression + 2*elevation])
      caseScrewA();
    }
  }


  connectXYTrayWithMainRails(elevation=5);

  module connectXYTrayWithMainRails(elevation=5) {

    attachSideConnectorModulesToYBars();

    function mainRailTrans(elevation) = translate(v=[0,0,elevation]) * yBarMainRailConnectorTrans;

    module railAndScrew(elevation) {
      mainRail();

      translate(v=[railSideMountThickness + 5, railFrontThickness + 4,railFootThickness + 2*elevation])
      caseScrewA();
    }

    multmatrix(mainRailTrans(elevation=10))
    railAndScrew(elevation=elevation);

    multmatrix(yBarMirrorOtherCornerTrans * mainRailTrans(elevation=10))
    railAndScrew(elevation=elevation);

    multmatrix(xBarSpaceToYBarSpace * xBarMirrorOtherCornerTrans * yBarSpaceToXBarSpace * mainRailTrans(elevation=10))
    railAndScrew(elevation=elevation);

    multmatrix(xBarSpaceToYBarSpace * xBarMirrorOtherCornerTrans * yBarSpaceToXBarSpace * yBarMirrorOtherCornerTrans * mainRailTrans(elevation=10))
    railAndScrew(elevation=elevation);
  }


  module insertDowelsIntoSideWall() {

  }


  module connectXYTraysWithSideWalls() {

  }


  module attachFeet() {

  }

  module attachTops() {

  }

}