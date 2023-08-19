include <../helper/common.scad>
include <./sharedVariables.scad>
include <./connector/connectors.scad>

module rackJoiner() {
  translate(v=[0,0,stackConnectorDualSpacing/2])
  stackConnectorPlug();

  mirror(v=[0,0,1])
  translate(v=[0,0,stackConnectorDualSpacing/2])
  stackConnectorPlug();

  translate(v=[0,0,-stackConnectorDualSpacing/2])
  cube(size=[connectorRectWidth+connectorRectPlugSlack, connectorRectDepth+connectorRectPlugSlack, stackConnectorDualSpacing]);
}

module rackFeet() {

  bandThickness = 2;
  height = 18;

  translate(v = [stackConnectorDx/2, 0, 2])
  mirror(v=[0,0,1]) {
    // stack connectors along rack x axis
    translate(v = [-(stackConnectorDx+connectorRectWidth)/2, -connectorRectDepth/2, 2-overhangSlack])
    mirror(v = [0, 0, 1]) {
      translate(v = [stackConnectorDx, 0, 0])
      stackConnectorBottom();

      stackConnectorBottom();
    }
    band();
  }

  module band() {
    intersection() {
      translate(v=[0,0,2])
      difference() {
        roundedCube(rackTotalWidth, inf50, height, 5, center = true);

        translate(v=[0,0,3])
        roundedCube(rackTotalWidth-6, inf50, height-6, 3, center = true);
      }

      halfspace(vpos=[0,1,-tan(feetProtrusionAngle)],p=[0,-8,2]);
      halfspace(vpos=[0,-1, tan(feetProtrusionAngle)],p=[0,6,2]);

      // TODO make these edge deburrings more parametric
      halfspace(vpos=[0,-1,0],p=[0,16,2]);
      halfspace(vpos=[0,1,0],p=[0,-5,2]);
    }

  }

  module roundedCube(x,y,z,r, center=false) {
    translate(v=[0,0,z/2])
    minkowski() {
      cube(size=[x-2*r,y,z-2*r], center=center);

      rotate(a=[90,0,0])
      cylinder(r=r, h=eps);
    }
  }
}

rackTopHandle();

module rackTopHandle() {


  handleWidth = 20;
  handleHeight = 50;

  handleTopThickness = 10;
  handleBottomThickness = 10;
  handleSideThickness = 10;

  handleR = baseRoundness;

  handleRing();

  module handleRing() {

    w = handleWidth - 2*handleR;
    st = max(eps,handleSideThickness - 2*handleR);
    bt = max(eps,handleBottomThickness - 2*handleR);
    tt = max(eps,handleTopThickness - 2*handleR);

    y =100;

    minkowski() {

      sphere(r=handleR);

      ringFourHull() {
        cube(size = [w, st, bt]);

        translate(v = [0, y-handleSideThickness, 0])
          cube(size = [w, st, bt]);

        translate(v = [0, y-handleSideThickness, handleHeight-handleTopThickness])
          cube(size = [w, st, tt]);

        translate(v = [0, 0, handleHeight-handleTopThickness])
          cube(size = [w, st, tt]);
      }
    }

  }


  module ringFourHull() {
    union() {
      hull() {children(0); children(1);}
      hull() {children(1); children(2);}
      hull() {children(2); children(3);}
      hull() {children(3); children(0);}
    }
  }
}