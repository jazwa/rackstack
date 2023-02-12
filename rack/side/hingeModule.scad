include <../config.scad>
include <./sideWallVariables.scad>
include <../sharedVariables.scad>
include <../../helper/halfspace.scad>
include <../../helper/screws.scad>


module hingeModule() {

  applyHingePole()
  applyYBarScrewMount()
  base();

  module base() {
    intersection() {
      cube(size = [sideWallConnW, sideWallConnD, sideWallConnLugDepression]);

      // TODO: pattern for this? beef up mirror4XY?
      cVal = 0.5;
      halfspace(p=[0,cVal,0], vpos=[0,1,1]);
      halfspace(p=[cVal,0,0], vpos=[1,0,1]);
      halfspace(p=[sideWallConnW-cVal,0,0], vpos=[-1,0,1]);
      halfspace(p=[0,sideWallConnD-cVal,0], vpos=[0,-1,1]);
    }
  }

  module applyHingePole() {
    apply_p() {
      translate(v = [sideWallConnW-hingePoleR, hingePoleR, sideWallConnH])
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
