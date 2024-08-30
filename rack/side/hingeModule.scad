include <../../helper/common.scad>
include <../../config/common.scad>
include <../sharedVariables.scad>
include <./sideWallVariables.scad>


module hingeModule(fixed=false) {

  applyHingePole()
  applyYBarScrewMount(fixed)
  base();

  module base() {
      
    connW = sideWallConnW;
    connD = sideWallConnD;

    intersection() {

      union() {
        cube(size = [connW, connD, sideWallConnLugDepression]);

        // Riser to enforce side wall hinge clearance
        translate(v = [0, 0, sideWallConnLugDepression])
        cube(size = [connW, connD - 12, sideWallZGapClearance]);
      }

      union() {
        // don't bevel the part around the dowel pin hole
        *cube(size = [connW, 2*(hingePoleR+radiusXYSlack) , sideWallConnLugDepression + sideWallZGapClearance]);

        // TODO: pattern for this? beef up mirror4XY?
        intersection() {
          cVal = 0.25;
          halfspace(p = [0, cVal, 0], vpos = [0, 1, 1]);
          halfspace(p = [cVal, 0, 0], vpos = [1, 0, 1]);
          halfspace(p = [connW-cVal, 0, 0], vpos = [-1, 0, 1]);
          halfspace(p = [0, connD-cVal, 0], vpos = [0, -1, 1]);
        }
      }
    }
  }

  module applyHingePole() {
    apply_n() {

      union() {
        translate(v = [sideWallConnW/2.0, hingePoleR + radiusXYSlack, 0])
        cylinder(r = hingePoleR + radiusXYSlack, h = inf50, $fn=64);

        translate(v = [sideWallConnW/2.0, 0 , 0])
        cube(size=[2, 5, inf50], center=true);
      }

      children(0);
    }
  }


  module applyYBarScrewMount(fixed=false) {
    apply_n() {

      if (!fixed) {
        translate(v = [yBarScrewHoleToOuterYEdge, yBarScrewHoleToFrontXEdge, sideWallConnLugDepression])
           counterSunkHead_N(rackFrameScrewType, headExtension = eps, screwExtension = inf10);
      }

      children(0);
    }
  }
}
