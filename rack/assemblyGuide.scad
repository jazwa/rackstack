include <../helper/common.scad>
include <../config/common.scad>
include <./mainRail.scad>
include <./yBar.scad>
include <./xBar.scad>
include <./side/magnetModule.scad>
include <./side/hingeModule.scad>
include <./side/sideWallRight.scad>
include <./side/sideWallLeft.scad>
include <./stackEnds.scad>
include <./xyPlate.scad>

include <../rack-mount/side-rail/dualMount.scad>

// TODO: this is completly broken. fix this and figure out a nice way to run this with cli commands
assemblyInstructions();

module assemblyInstructions () {

  screwMask = false;
  plasticMask = false;
  sideSupportRailMask = true;

  // Instruction List (in order)
  // render()
  // addHeatSetInsertsYBar(at=$t);
  // addMagnetsToMagnetModules(at=$t);
  // addMagnetsToSideWall(at=$t);
  // attachXBarWithYBar(at=$t);
  // screwXBarAndYBar(at=$t);
  // attachSideConnectorModulesToYBars(at=$t);
  // connectXYTrayWithMainRails(at=1);
  // insertDowelsIntoSideWall(at=$t);
  // propUpBottomXYTraywithSideWalls(at=$t);
  // attachXYTrays(at=$t);
  // slideHexNutToFeet(at=$t);
  // insertFeet(at=$t);
  // screwFeet(at=$t);
  // attachXYPlates(at=$t);


  // Final builds:
  // render()
   finalSingle();
  // finalDouble();

  // Features:
  // render()
  // slideInNuts(at=$t);
  // stackable(at=$t); // recommended at least 32 frames for animation
  // sideSwivel(at=$t);


  module addHeatSetInsertsYBar(at=0) {
    t = lerp(a=10,b=0.35,t=at); // non zero b for exposing the heatset gears for diagramming

    if (!plasticMask) {
      yBar();
    }

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
      heatSetInsert(rackFrameScrewType);

      multmatrix(mainRailHeatSetTrans(t = t))
      heatSetInsert(rackFrameScrewType);

      multmatrix(xBarHeatSetTrans(t = t))
      heatSetInsert(rackFrameScrewType);
    }

    if (!screwMask) {
      heatSetInsertsOneCorner(t = t);

      multmatrix(yBarMirrorOtherCornerTrans)
      heatSetInsertsOneCorner(t = t);
    }

  }

  module addMagnetsToMagnetModules(at=0) {
    t = lerp(a=8,b=0,t=at);

    if (!plasticMask) {
      magnetModule();
    }

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

    if (!plasticMask) {
      sideWallLeft();
    }

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

    if (!plasticMask) {
      multmatrix(xBarSpaceToYBarSpace)
      xBar();

      multmatrix(yBarMirrorOtherCornerTrans*xBarSpaceToYBarSpace)
      xBar();
    }
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

      if (!plasticMask) { xBar(); }

      multmatrix(xBarYBarScrewTrans(screwExtension))
      caseScrewB();

      multmatrix(xBarMirrorOtherCornerTrans * xBarYBarScrewTrans(screwExtension))
      caseScrewB();
    }

    multmatrix(yBarMirrorOtherCornerTrans*xBarSpaceToYBarSpace)
    union() {
      if (!plasticMask) { xBar(); }

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

      if (!plasticMask) {
        hingeModule();
      }

      translate(v=[yBarScrewHoleToOuterYEdge,yBarScrewHoleToFrontXEdge,sideWallConnLugDepression + 2*elevation])
      caseScrewA();
    }

    multmatrix(xBarSpaceToYBarSpace * xBarMirrorOtherCornerTrans * yBarSpaceToXBarSpace * yBarMirrorOtherCornerTrans * sideModuleTrans(elevation))
    union() {
      if (!plasticMask) {
        hingeModule();
      }

      translate(v=[yBarScrewHoleToOuterYEdge,yBarScrewHoleToFrontXEdge,sideWallConnLugDepression + 2*elevation])
      caseScrewA();
    }
  }

  module connectXYTrayWithMainRails(at=0) {

    elevation = lerp(a=5, b=0, t=at);

    attachSideConnectorModulesToYBars(at=1);

    function mainRailTrans(elevation) = translate(v=[0,0,elevation]) * yBarMainRailConnectorTrans;

    module railAndScrew(elevation) {

      if (!plasticMask) {
        mainRail();
      }

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

  module attachXYTrays(at=0,r=0) {

    t = lerp(a=10,b=0,t=at);

    module singleScrew(t=0) {
      translate(v = [railSideMountThickness+5, railFrontThickness+4, railFootThickness + 2*t])
      caseScrewA();
    }

    translate(v=[0,0,t])
    multmatrix(upperXYTrayTrans) {
      attachSideConnectorModulesToYBars(at=1);

      mirrorAllTrayCornersFromYBarSpace()
      multmatrix(yBarMainRailConnectorTrans)
      singleScrew(t=t);
    }

    propUpBottomXYTraywithSideWalls(at=1,r=r);
  }

  module attachXYPlates(at=0,r=0) {

    t = lerp(a=10,b=0,t=at);

    // TODO fix xyPlate transformations
    function xyPlateToYBarTrans() = translate(v=[6,6,0]) * yBarBasePlateConnectorTrans;

    attachXYTrays(at=1,r=r);

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

      if (!plasticMask) {
        translate(v = [0, 0, -t])
        xyPlate();
      }

      screw(t=2*t);

      translate(v=[xyPlateConnDx, 0,0])
      screw(t=2*t);

      translate(v=[0, xyPlateConnDy,0])
      screw(t=2*t);

      translate(v=[xyPlateConnDx, xyPlateConnDy,0])
      screw(t=2*t);
    }
  }

  module slideHexNutToFeet(at=0) {

    t = lerp(a=8, b=0, t=at);

    module slideNut() {
      if (!screwMask) {
        rotate(a = [0, 0, 90])
        rotate(a = [90, 0, 0])
        hexNut(rackFrameScrewType);
      }
    }

    translate(v=[0,t,connectorBottomToScrew + 0.5]) // where does this come from again? slack?
    slideNut();

    translate(v=[stackConnectorDx,t,connectorBottomToScrew + 0.5]) // where does this come from again? slack?
    slideNut();

    if (!plasticMask) {
      stackConnectorFeet();
    }
  }

  module insertFeet(at=0,r=0) {

    t = lerp(a=10,b=0,t=at);

    attachXYPlates(at=1,r=r);

    multmatrix(feetToYBarTrans(t=t))
    slideHexNutToFeet(at=1);

    multmatrix(yBarMirrorOtherCornerTrans * feetToYBarTrans(t=t))
    slideHexNutToFeet(at=1);
  }

  module screwFeet(at=0,r=0) {

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

    insertFeet(at=1,r=r);
  }


  module finalSingle(r=0) {
    screwFeet(at=1,r=r);

    for (i = [1, 5, 9, 13, 17]) {
      translate(v = [2, frontScrewSpacing+railFrontThickness+railSlotToXZ, i*10])
      multmatrix(yBarMainRailConnectorTrans)
      union() {
        if (!sideSupportRailMask) {
          sideSupportRailBase("lBracket");
        }

        rotate(a = [0, -90, 0])
        caseScrewA();

        translate(v = [0, sideRailScrewMountDist, 0])
        rotate(a = [0, -90, 0])
        caseScrewA();
      }
    }

    multmatrix(xBarSpaceToYBarSpace*xBarMirrorOtherCornerTrans*yBarSpaceToXBarSpace)
    for (i = [1, 5, 9, 13, 17]) {
      translate(v = [2, frontScrewSpacing+railFrontThickness+railSlotToXZ, i*10])
      multmatrix(yBarMainRailConnectorTrans)
      union() {
        if (!sideSupportRailMask) {
          sideSupportRailBase("lBracket");
        }
        rotate(a=[0,-90,0])
        caseScrewA();

        translate(v=[0,sideRailScrewMountDist,0])
        rotate(a=[0,-90,0])
        caseScrewA();
      }
    }
  }


  module finalDouble(r=0) {
    stackable(at=1,r=r);
  }

  module slideInNuts(at=0) {

    t = lerp(a=15,b=0,t=at);

    screwFeet(at=1);

    slideInScrew(t=t, i=1);
    slideInScrew(t=t, i=4);

    module slideInScrew(t=0, i=1) {
      translate(v = [railScrewHoleToOuterEdge + t, railFrontThickness/2, railFootThickness+(10*i)])
      multmatrix(yBarMainRailConnectorTrans)
      rotate(a = [90, 0, 0])
      hexNut(mainRailScrewType);
    }
  }

  module slideInStackConnectorNut(at=0) {

    t = lerp(a=10,b=0,t=at);

    module slidingNut(t=0) {
      translate(v=[connectorRectWidth/2,connectorRectDepth/2 - t,connectorBottomToScrew+stackConnectorDualSpacing/2])
      rotate(a=[90,0,0])
      rotate(a=[0,90,0])
      hexNut(rackFrameScrewType);
    }

    slidingNut(t=t);

    mirror(v=[0,0,1])
    slidingNut(t=t);

    translate(v=[0,connectorRectDepth,0])
    mirror(v=[0,1,0])
    stackConnectorDual();
  }

  module stackable(at=0,r=0) {

    t1 = lerp(a=0, b=1,  t=min(3*at, 1));
    t2 = lerp(a=30, b=0, t=min(max(3*at-1,0),1));
    t3 = lerp(a=15, b=0, t=max(3*at-2, 0));

    module stackConnectors() {
      mirrorAllTrayCornersFromYBarSpace()
      multmatrix(stackConnectorTrans(t=0))
      slideInStackConnectorNut(t1);
    }

    module singleTrayScrews() {
      screwTrans = feetToYBarTrans(t=0) * translate(v=[-t3 - 9,0,connectorBottomToScrew]) * rotate(a=[0,-90,0]);

      mirrorAllTrayCornersFromYBarSpace()
      multmatrix(screwTrans)
      caseScrewB();
    }

    if (!plasticMask) {
      translate(v = [0, 0, t2/2])
      stackConnectors();
    }

    if (at >= 2/3) {
      multmatrix(secondStackTrans)
      singleTrayScrews();

      multmatrix(upperXYTrayTrans)
      singleTrayScrews();
    }

    translate(v=[0,0,t2])
    multmatrix(secondStackTrans)
    attachXYPlates(at=1,r=r);

    screwFeet(at=1,r=20);

  }

  module sideSwivel(at=0) {
    r = abs(lerp(a=-110,b=110,t=at));

    finalSingle(r=r);
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


  module caseScrewA() {
    if (!screwMask) {
      color([1, 1, 1]) {
        difference() {
          scale(v = [0.9, 0.9, 0.9])
          counterSunkHead_N(rackFrameScrewType, screwExtension = 6, headExtension = 0.5);

          cylinder($fn = 6, r = 1.5);
        }
      }
    }
  }

  module caseScrewB() {
    if (!screwMask) {
      color([1, 1, 1]) {
        difference() {
          scale(v = [0.9, 0.9, 0.9])
          counterSunkHead_N(rackFrameScrewType, screwExtension = 10, headExtension = 0.5);

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

}