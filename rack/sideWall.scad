include <../helper/math.scad>
include <../helper/halfspace.scad>
include <../misc/magnet.scad>
include <./config.scad>
include <./mainRail.scad>
include <./side/sideWallMagnetMount.scad>
include <./sharedVariables.scad>

include <./side/magnetModule.scad>
include <./side/hingeModule.scad>


sideWallZGapClearance = 0.2;
sideWallZ = railTotalHeight - 2*(railFootThickness + sideWallZGapClearance);

sideWallY = yBarDepth;

sideWallXGapClearance = 0.2;
sideWallX = (yBarWidth-(railTotalWidth+railSlotToInnerYEdge)) - sideWallXGapClearance;

hingePoleDx = hingePoleToConnectorOuterYZFace + sideWallSlotToOuterYEdge;
hingePoleDy = hingePoleToConnectorOuterXZFace + sideWallSlotToOuterXEdge;

echo("Side Wall Height", sideWallZ);
echo("Side Wall Depth", sideWallY);

module sideWall() {

  applyHingeConnector()
  applyMagnetConnector()
  applyEpicVentilation()
  applyHingeHandle()
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

    hingeHoleShellR = hingeHoleR+1;

    apply_pn() {
      hull() {
        hingeShell();
        hingeBacksideProjectionPlane();
      }

      union() {
        hingeHole();
        // Trim parts of the wall for rotational clearance
        halfspace(p=[sideWallX-5, sideWallY, 0], vpos=[1,1.5,0]);
      }

      children(0);
    }

    module hingeShell() {
      translate(v = [sideWallX-hingePoleDx, sideWallY-(sideWallThickness+hingePoleDy), 0])
      cylinder(r = hingeHoleShellR, h = sideWallZ);
    }

    // XZ plane in line with the back of the case. Project the hinge pole shell onto this to fill any weird
    // geometries from the curves of the side wall
    module hingeBacksideProjectionPlane() {
      translate(v=[sideWallX-hingePoleDx - hingeHoleShellR,sideWallY,0])
      cube(size=[2*hingeHoleShellR, eps, sideWallZ]);
    }

    module hingeHole() {
      translate(v = [sideWallX-hingePoleDx, sideWallY-(sideWallThickness+hingePoleDy), 0])
      cylinder(r = hingeHoleR, h = sideWallZ);
    }
  }

  // TODO: add correct magnet translations, also remove random variables
  module applyMagnetConnector() {
    apply_p() {
      union() {
        translate(v = [sideWallThickness, magnetMountToYBarFront, magnetMountToYBarTop])
        sideWallMagnetMountRotated();

        translate(v = [sideWallThickness, magnetMountToYBarFront, sideWallZ - magnetMountToYBarTop])
        sideWallMagnetMountRotated();
      }

      children(0);
    }


    module sideWallMagnetMountRotated() {
      rotate(a=[0,90,0])
      sideWallMagnetMount();
    }
  }

  module applyEpicVentilation() {
    children(0);
  }

  module applyHingeHandle() {
    children(0);
  }
}


sideWall();

translate(v=[10,sideWallSlotToXZ,-2])
mirror(v=[1,0,0])
magnetModule();

translate(v=[3,100,0])
mirror(v=[0,1,0])
hingeModule();
