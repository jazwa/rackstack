include <../../helper/common.scad>
include <../../config/common.scad>
include <../sharedVariables.scad>
include <./sideWallVariables.scad>


module magnetModule(fixed=false) {

  applyYBarScrewMount(fixed)
  applyMagnetMount()
  base();

  module base() {

    connW = sideWallConnW;
    connD = sideWallConnD;

    intersection() {
    
      cube(size = [connW, connD, sideWallConnLugDepression]);

      // TODO: pattern for this? beef up mirror4XY?
      cVal = 0.25;
      halfspace(p=[0,cVal,0], vpos=[0,1,1]);
      halfspace(p=[cVal,0,0], vpos=[1,0,1]);
      halfspace(p=[connW-cVal,0,0], vpos=[-1,0,1]);
      halfspace(p=[0,connD-cVal,0], vpos=[0,-1,1]);
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

  module applyMagnetMount() {
    apply_pn() {
      magnetMountShell();
      magnetMountHole();
      children(0);
    }

    module magnetMountShell() {
      hull() {
        translate(v = [0, magnetModuleMagnetMountDy, magnetModuleMagnetMountDz])
        rotate(a = [0, 90, 0])
        cylinder(r = magnetMountShellRadius, h = sideWallConnW-magnetFaceToSideWallConnOuterYEdge);

        translate(v = [0, 2, sideWallConnH])
        cube(size = [sideWallConnW-magnetFaceToSideWallConnOuterYEdge, 2*magnetMountShellRadius, eps]);
      }
    }

    module magnetMountHole() {
      translate(v = [sideWallConnW-(magnetFaceToSideWallConnOuterYEdge+magnetHSlacked),
        magnetModuleMagnetMountDy,
        magnetModuleMagnetMountDz])
      rotate(a = [0, 90, 0])
      cylinder(r = magnetRSlacked, h = magnetHSlacked);
    }
  }

}
