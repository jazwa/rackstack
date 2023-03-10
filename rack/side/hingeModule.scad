include <../config.scad>
include <./sideWallVariables.scad>
include <../sharedVariables.scad>
include <../../helper/halfspace.scad>
include <../../helper/screws.scad>

translate(v=[10,20,-2 - sideWallZHingeTotalClearance])
*hingeModule();

module hingeModule() {

  applyHingePole()
  applyYBarScrewMount()
  base();

  connSlack = 0.1;
  connW = sideWallConnW - connSlack;
  connD = sideWallConnD - connSlack;

  module base() {
    translate(v=[connSlack, connSlack,0])
    intersection() {

      union() {
        cube(size = [connW, connD, sideWallConnLugDepression]);

        // Riser to enforce side wall hinge clearance
        translate(v = [0, 0, sideWallConnLugDepression])
        cube(size = [connW, connD - 12, sideWallZGapClearance]);
      }

      // TODO: pattern for this? beef up mirror4XY?
      cVal = 0.5;
      halfspace(p=[0,cVal,0], vpos=[0,1,1]);
      halfspace(p=[cVal,0,0], vpos=[1,0,1]);
      halfspace(p=[connW-cVal,0,0], vpos=[-1,0,1]);
      halfspace(p=[0,connD-cVal,0], vpos=[0,-1,1]);
    }
  }

  module applyHingePole() {
    apply_p() {
      translate(v = [sideWallConnW/2.0, hingePoleR, sideWallConnH])
      cylinder(r = hingePoleR, h = hingePoleH);

      children(0);
    }
  }


  module applyYBarScrewMount() {
    apply_n() {
      translate(v = [yBarScrewHoleToOuterYEdge, yBarScrewHoleToFrontXEdge, sideWallConnLugDepression])
      counterSunkHead_N(rackFrameScrewType, headExtension = eps, screwExtension = inf10);

      children(0);
    }
  }
}
