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


module sideWall() {

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