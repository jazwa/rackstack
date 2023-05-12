include <../helper/math.scad>
include <./config.scad>
include <./mainRail.scad>
include <./yBar.scad>
include <./xBar.scad>
include <./side/magnetModule.scad>
include <./side/hingeModule.scad>
include <./side/sideWallRight.scad>
include <./side/sideWallLeft.scad>
include <./stackEnds.scad>
include <./xyPlate.scad>

assemblyInstructions();

module assemblyInstructions () {

  // Instruction List (in order)
  // TODO: add steps to glue magnets and add heatset inserts

  //render()
  // addHeatSetInsertsYBar(at=$t);
  // addMagnetsToMagnetModules(at=$t);
  // addMagnetsToSideWall(at=$t);
  // attachXBarWithYBar(at=$t);
  // screwXBarAndYBar(at=$t);
  // attachSideConnectorModulesToYBars(at=$t);
  // connectXYTrayWithMainRails(at=$t);
  // insertDowelsIntoSideWall(at=$t);
  // propUpBottomXYTraywithSideWalls(at=$t);
  // attachXYTrays(at=$t);
  // slideHexNutToFeet(at=$t);
  // insertFeet(at=$t);
  // screwFeet(at=$t);
  // attachXYPlates(at=$t);

  // end instructions
  final();


  module addHeatSetInsertsYBar(at=0) {
    t = lerp(a=10,b=0,t=at);

    yBar();

    heatSetHeight = heatSetInsertSlotHeightSlacked(rackFrameScrewType) * 0.95;

    function sideModuleHeatSetTrans(t=0) =
      translate(v=[yBarScrewHoleToOuterYEdge,yBarScrewHoleToFrontXEdge,t-(heatSetHeight+sideWallConnLugDepression)]) *
      yBarSideModuleConnectorTrans;

    function mainRailHeatSetTrans(t=0) =
      translate(v=[mainRailHeatSetOnYBarDx,mainRailHeatSetOnYBarDy,t-heatSetHeight]) *
      yBarMainRailConnectorTrans;

    function xBarHeatSetTrans(t=0) =
      translate(v=[t-heatSetHeight,27,6]) *
      yBarXBarConnectorTrans *
      rotate(a=[0,90,0]);

    module heatSetInsertsOneCorner(t=0) {
      multmatrix(sideModuleHeatSetTrans(t = t))
      heatSetInsert();

      multmatrix(mainRailHeatSetTrans(t = t))
      heatSetInsert();

      multmatrix(xBarHeatSetTrans(t = t))
      heatSetInsert();
    }

    heatSetInsertsOneCorner(t=t);

    multmatrix(yBarMirrorOtherCornerTrans)
    heatSetInsertsOneCorner(t=t);

  }

  module addMagnetsToMagnetModules(at=0) {
    t = lerp(a=8,b=0,t=at);

    magnetModule();

    function insertMagnetTrans(t=0) =
      translate(v=[sideWallConnW-(magnetFaceToSideWallConnOuterYEdge+magnetHSlacked) + t,
                   magnetModuleMagnetMountDy,
                   magnetModuleMagnetMountDz]) *
      rotate(a=[0,90,0]);

    multmatrix(insertMagnetTrans(t=t))
    magnet();
  }

  module addMagnetsToSideWall(at=0) {
    t = lerp(a=8,b=0,t=at);

    sideWallLeft();

    function insertMagnetTrans(t=0) =
      translate(v=[sideWallThickness+t, magnetMountToYBarFront, magnetMountToYBarTop-sideWallZHingeTotalClearance]) *
      rotate(a=[0,90,0]);

    multmatrix(insertMagnetTrans(t=t))
    magnet();

    multmatrix(translate(v=[0,0,sideWallZ - 2*(magnetMountToYBarTop- sideWallZHingeTotalClearance)]) * insertMagnetTrans(t=t))
    magnet();
  }

  module attachXBarWithYBar(at=0) {

    t = lerp(a=20, b=0, t=at);

    // assemble x-y bar trays
    multmatrix(translate(v = [0, 0, t]))
    addHeatSetInsertsYBar(at=1);

    multmatrix(translate(v = [0, 0, t])*xBarSpaceToYBarSpace*xBarMirrorOtherCornerTrans*yBarSpaceToXBarSpace)
    addHeatSetInsertsYBar(at=1);

    multmatrix(xBarSpaceToYBarSpace)
    xBar();

    multmatrix(yBarMirrorOtherCornerTrans*xBarSpaceToYBarSpace)
    xBar();
  }

  module screwXBarAndYBar(at=0) {
    screwExtension = lerp(a=15, b=0, t=at);

    // in x bar space
    function xBarYBarScrewTrans(extension) =
      translate(v=[27,xBarSideThickness + extension,6]) * rotate(a=[270,0,0]);

    // screw to connect x and y bars
    addHeatSetInsertsYBar(at=1);

    multmatrix(xBarSpaceToYBarSpace*xBarMirrorOtherCornerTrans*yBarSpaceToXBarSpace)
    addHeatSetInsertsYBar(at=1);

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

  module attachSideConnectorModulesToYBars(at=0) {
    elevation = lerp(a=8, b=0, t=at);

    // side module to front corner ybar
    function sideModuleTrans(t=0) =
        translate(v=[sideWallConnW,0,t-sideWallConnLugDepression])
        * yBarSideModuleConnectorTrans
      * mirror(v=[1,0,0]); // mirror for magnetModule

    screwXBarAndYBar(at=1);

    multmatrix(sideModuleTrans(elevation))
    union() {
      addMagnetsToMagnetModules(at=1);

      translate(v=[yBarScrewHoleToOuterYEdge,yBarScrewHoleToFrontXEdge,sideWallConnLugDepression + 2*elevation])
      caseScrewA();
    }

    multmatrix(xBarSpaceToYBarSpace * xBarMirrorOtherCornerTrans * yBarSpaceToXBarSpace * sideModuleTrans(elevation))
    union() {
      addMagnetsToMagnetModules(at=1);

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

  module connectXYTrayWithMainRails(at=0) {

    elevation = lerp(a=5, b=0, t=at);

    attachSideConnectorModulesToYBars(at=1);

    function mainRailTrans(elevation) = translate(v=[0,0,elevation]) * yBarMainRailConnectorTrans;

    module railAndScrew(elevation) {
      mainRail();

      translate(v=[railSideMountThickness + 5, railFrontThickness + 4,railFootThickness + 2*elevation])
      caseScrewA();
    }

    multmatrix(mainRailTrans(elevation=elevation))
    railAndScrew(elevation=elevation);

    multmatrix(yBarMirrorOtherCornerTrans * mainRailTrans(elevation=elevation))
    railAndScrew(elevation=elevation);

    multmatrix(xBarSpaceToYBarSpace * xBarMirrorOtherCornerTrans * yBarSpaceToXBarSpace * mainRailTrans(elevation=elevation))
    railAndScrew(elevation=elevation);

    multmatrix(xBarSpaceToYBarSpace * xBarMirrorOtherCornerTrans * yBarSpaceToXBarSpace * yBarMirrorOtherCornerTrans * mainRailTrans(elevation=elevation))
    railAndScrew(elevation=elevation);
  }

  module insertDowelsIntoSideWall(at=0) {

    t = lerp(a=10, b=0, t=at);

    hingeHoleH = hingePoleH-sideWallConnLugDepression;

    addMagnetsToSideWall(at=1);

    translate(v=[hingePoleDx,hingePoleDy, (sideWallZ-hingeHoleH) + t])
    hingeDowel();

    translate(v=[hingePoleDx,hingePoleDy, (hingeHoleH-hingePoleH)-t])
    hingeDowel();

  }

  module propUpBottomXYTraywithSideWalls(at=0, r=0) {

    t = lerp(a=10,b=0,t=at);

    function sideWallToYBarTrans(t=0,r=0) =
        yBarMirrorOtherCornerTrans *
        yBarSideModuleConnectorTrans * // bring to y bar space
        mirror(v=[0,1,0]) *
        translate(v=[0,0,t]) *
        translate(v=[sideWallConnW/2.0, -hingePoleR, sideWallZHingeTotalClearance]) * // bring to side module space
        rotate(a=[0,0,-r]) *
        translate(v=[-hingePoleDx, -hingePoleDy, 0]);

    connectXYTrayWithMainRails(at=1);

    multmatrix(sideWallToYBarTrans(t=t, r=r))
    insertDowelsIntoSideWall(at=1);

    multmatrix(xBarSpaceToYBarSpace * xBarMirrorOtherCornerTrans * yBarSpaceToXBarSpace * sideWallToYBarTrans(t=t,r=r))
    insertDowelsIntoSideWall(at=1);
  }

  module attachXYTrays(at=0) {

    t = lerp(a=10,b=0,t=at);

    module singleScrew(t=0) {
      translate(v = [railSideMountThickness+5, railFrontThickness+4, railFootThickness + 2*t])
      caseScrewA();
    }

    translate(v=[0,0,t])
    multmatrix(upperXYTrayTrans) {
      attachSideConnectorModulesToYBars(at=1);

      multmatrix(yBarMainRailConnectorTrans)
      singleScrew(t=t);

      multmatrix(yBarMirrorOtherCornerTrans * yBarMainRailConnectorTrans)
      singleScrew(t=t);

      multmatrix(xBarSpaceToYBarSpace * xBarMirrorOtherCornerTrans * yBarSpaceToXBarSpace * yBarMirrorOtherCornerTrans * yBarMainRailConnectorTrans)
      singleScrew(t=t);

      multmatrix(xBarSpaceToYBarSpace * xBarMirrorOtherCornerTrans * yBarSpaceToXBarSpace * yBarMirrorOtherCornerTrans * yBarMirrorOtherCornerTrans * yBarMainRailConnectorTrans)
      singleScrew(t=t);

    }

    propUpBottomXYTraywithSideWalls(at=1,r=0);
  }

  module slideHexNutToFeet(at=0) {

    t = lerp(a=8, b=0, t=at);

    module slideNut() {
      rotate(a = [0, 0, 90])
      rotate(a = [90, 0, 0])
      color([0, 1, 1])
      hexNut(rackFrameScrewType);
    }

    translate(v=[0,t,connectorBottomToScrew + 0.5]) // where does this come from again? slack?
    slideNut();

    translate(v=[stackConnectorDx,t,connectorBottomToScrew + 0.5]) // where does this come from again? slack?
    slideNut();

    stackConnectorFeet();
  }

  module insertFeet(at=0) {

    t = lerp(a=10,b=0,t=at);

    attachXYTrays(at=1);

    multmatrix(feetToYBarTrans(t=t))
    slideHexNutToFeet(at=1);

    multmatrix(yBarMirrorOtherCornerTrans * feetToYBarTrans(t=t))
    slideHexNutToFeet(at=1);
  }

  module screwFeet(at=0) {

    t = lerp(a=20, b=0, t=at);

    function screwTrans(t=0) = translate(v=[-t - 9,0,connectorBottomToScrew]) * rotate(a=[0,-90,0]);
    mirrorOtherFeetStackConnectorTrans = translate(v=[stackConnectorDx,0,0]) * mirror(v=[1,0,0]);


    module screwToFeetModule() {
      multmatrix(feetToYBarTrans(t = 0)*screwTrans(t = t))
      caseScrewB(); // we might want a longer screw?

      multmatrix(feetToYBarTrans(t = 0)*mirrorOtherFeetStackConnectorTrans*screwTrans(t = t))
      caseScrewB();
    }

    screwToFeetModule();

    multmatrix(yBarMirrorOtherCornerTrans)
    screwToFeetModule();

    insertFeet(at=1);
  }

  module attachXYPlates(at=0) {

    t = lerp(a=10,b=0,t=at);

    // TODO fix xyPlate transformations
    function xyPlateToYBarTrans() = translate(v=[6,6,0]) * yBarBasePlateConnectorTrans;

    screwFeet(at=1);

    multmatrix(xyPlateToYBarTrans())
    xyPlateWithScrews(t=t);

    multmatrix(upperXYTrayTrans * xyPlateToYBarTrans())
    xyPlateWithScrews(t=t);

    module xyPlateWithScrews(t=0) {

      module screw(t=0) {
        translate(v=[0,0,-t])
        mirror(v=[0,0,1])
        caseScrewA();
      }

      translate(v=[0,0,-t])
      xyPlate();

      screw(t=2*t);

      translate(v=[xyPlateConnDx, 0,0])
      screw(t=2*t);

      translate(v=[0, xyPlateConnDy,0])
      screw(t=2*t);

      translate(v=[xyPlateConnDx, xyPlateConnDy,0])
      screw(t=2*t);
    }
  }

  module final() {
    attachXYPlates(at=1);
  }

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

  module hingeDowel() {
    color([0,1,1])
    cylinder(h=dowelPinH, r=dowelPinR);
  }

  module heatSetInsert() {
    color([1,0,1])
    scale(v=[0.95,0.95,0.95])
    heatSetInsertSlot_N(screwType=rackFrameScrewType, topExtension=0);
  }

  module magnet() {
    color([1,0,1])
    cylinder(r=magnetR, h=magnetH);
  }

  module arrow(length) {
    color([1,0,1]) {
      translate(v = [0, 0, length-2])
      cylinder(r1 = 2, r2 = 0.2, h = 2);

      cylinder(r = 1, h = length-2);
    }
  }

}