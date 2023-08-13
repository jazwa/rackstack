include <./common.scad>
include <./screwFeet.scad>

// TODO fix this
module finalBuilds () {

  // Final builds:
  // render()
  // finalSingle();
  // finalDouble();

  // Features:
  // render()
  // slideInNuts(at=$t);
  // stackable(at=$t);
  // sideSwivel(at=$t);

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
        caseScrewMedium();

        translate(v = [0, sideRailScrewMountDist, 0])
        rotate(a = [0, -90, 0])
        caseScrewMedium();
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
        caseScrewMedium();

        translate(v=[0,sideRailScrewMountDist,0])
        rotate(a=[0,-90,0])
        caseScrewMedium();
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
      caseScrewLong();
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


}