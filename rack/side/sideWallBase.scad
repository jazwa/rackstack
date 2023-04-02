include <../../helper/math.scad>
include <../../helper/halfspace.scad>
include <../../helper/magnet.scad>
include <../config.scad>

include <./sideWallMagnetMount.scad>
include <./sideWallVariables.scad>
include <../sharedVariables.scad>

include <./magnetModule.scad>
include <./hingeModule.scad>

echo("Side Wall Height", sideWallZ);
echo("Side Wall Depth", sideWallY);

//translate(v = [hingePoleDx ,hingePoleDy, 10])
//rotate(a=[0,0,-120])
//translate(v = [-hingePoleDx ,-hingePoleDy, 0])
sideWallBase();

module sideWallBase() {

  applyHingeConnector()
  applyMagnetConnector()
  applyHandle()
  sideWallBase();

  module sideWallBase() {

    module sideWallShellHelper(x,y,z,r) {
      translate(v=[r, r, 0])
      minkowski() {
        cube(size = [x-r, y - 2*r, z]);
        sphere(r = r);
      }
    }

    intersection() {
      difference() {
        sideWallShellHelper(sideWallX,sideWallY,sideWallZ, baseRoundness);

        translate(v=[sideWallThickness, sideWallThickness,0])
        sideWallShellHelper(sideWallX,sideWallY - 2*sideWallThickness, sideWallZ, baseRoundness - sideWallThickness);
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
        hingeSideProjectionPlane();
      }

      union() {
        hingeHole();

        // Trim parts of the wall for rotational clearance
        halfspace(p=[0, sideWallY-2.5, 0], vpos=[-0.5,1,0]); // flat area to limit rotation against the main rail
        halfspace(p=[sideWallX-10, sideWallY, 0], vpos=[1,2.5,0]);
      }

      children(0);
    }

    module hingeShell() {
      translate(v = [hingePoleDx, hingePoleDy, 0])
      cylinder(r = hingeHoleShellR, h = sideWallZ);
    }

    // XZ plane in line with the back of the case. Project the hinge pole shell onto this to fill any weird
    // geometries from the curves of the side wall
    module hingeSideProjectionPlane() {
      translate(v=[sideWallThickness, hingePoleDy - hingeHoleShellR, 0])
      cube(size=[eps, 2*hingeHoleShellR, sideWallZ]);
    }

    module hingeHole() {
      translate(v = [hingePoleDx , hingePoleDy, 0])
      cylinder(r = hingeHoleR, h = sideWallZ);
    }
  }

  // TODO: add correct magnet translations, also remove random variables
  module applyMagnetConnector() {
    apply_p() {
      union() {
        translate(v = [sideWallThickness, magnetMountToYBarFront, magnetMountToYBarTop - sideWallZHingeTotalClearance])
        sideWallMagnetMountRotated();

        translate(v = [sideWallThickness, magnetMountToYBarFront, sideWallZ - (magnetMountToYBarTop- sideWallZHingeTotalClearance)])
        sideWallMagnetMountRotated();
      }

      children(0);
    }

    module sideWallMagnetMountRotated() {
      rotate(a=[0,90,0])
      sideWallMagnetMount();
    }
  }

  module applyHandle() {

    handleWidth = 8;
    handleLength = 60;
    handleRoundness = 7;
    widthOffset = 3;

    apply_n() {

      minkowski() {
        sphere(r=handleRoundness);

        translate(v = [sideWallX -(handleWidth-handleRoundness) + widthOffset, 0, (sideWallZ-handleLength)/2])
        cube(size = [handleWidth-handleRoundness, sideWallThickness, handleLength-handleRoundness]);
      }

      children(0);
    }
  }
}
