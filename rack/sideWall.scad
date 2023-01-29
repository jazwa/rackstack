include <../helper/math.scad>
include <../helper/halfspace.scad>
include <../misc/magnet.scad>
include <./config.scad>
include <./yBar.scad>
include <./sideWallConnector.scad>
include <./sharedVariables.scad>


sideWallZ = 110;
sideWallY = 110;
sideWallX = 12;

sideWallZGapClearance = 0.2;


// make these global
hingePoleToInnerSideWallX = (hingePoleToConnectorOuterYZFace + sideWallSlotToOuterYEdge) - sideWallThickness;
hingePoleToInnerSideWallY = (hingePoleToConnectorOuterXZFace + sideWallSlotToOuterXEdge) - sideWallThickness;


module sideWall() {

  applyHingeConnector()
  applyMagnetConnector()
  sideWallBase();


  module sideWallBase() {

    module roundThingHelper(x,y,z,r) {
      translate(v=[r, r, 0])
      minkowski() {
        cube(size = [x-r, y - 2*r, z]);
        sphere(r = r);
      }
    }

    intersection() {
      difference() {
        roundThingHelper(sideWallX,sideWallY,sideWallZ, baseRoundness);

        translate(v=[sideWallThickness, sideWallThickness,0])
        roundThingHelper(sideWallX,sideWallY - 2*sideWallThickness,sideWallZ, baseRoundness);
      }

      halfspace(vpos=[-1,0,0], p=[sideWallX,0,0]);
      halfspace(vpos=[0,0,-1], p=[0,0,sideWallZ]);
      halfspace(vpos=[0,0,1], p=[0,0,0]);
    }
  }


  module applyHingeConnector() {

    hingeHolePositiveRad = hingeHoleR+1;

    module hingeProjectConstructionPlane() {
      translate(v=[sideWallX-(sideWallThickness+hingePoleToInnerSideWallX) - hingeHolePositiveRad,sideWallY,0])
      cube(size=[2*hingeHolePositiveRad, eps, sideWallZ]);
    }

    apply_pn() {

      hull() {
        translate(v = [sideWallX-(sideWallThickness+hingePoleToInnerSideWallX), sideWallY-(sideWallThickness+
          hingePoleToInnerSideWallY), 0])
        cylinder(r = hingeHoleR+1, h = sideWallZ);

        hingeProjectConstructionPlane();
      }

      union() {
        translate(v = [sideWallX-(sideWallThickness+hingePoleToInnerSideWallX), sideWallY-(sideWallThickness+
          hingePoleToInnerSideWallY), 0])
        cylinder(r = hingeHoleR, h = sideWallZ);

        // TODO annoying constant
        halfspace(p=[sideWallX-3.3, sideWallY, 0], vpos=[1,1,0]);
      }

      children(0);
    }
  }

  module applyMagnetConnector() {
    apply_p() {

      translate(v=[sideWallThickness,10,10])
      rotate(a=[0,90,0])
      sideWallConnectorMagnetSide();

      children(0);
    }
  }

  module applyEpicVentilation() {

  }
}

sideWall();

