include <./common.scad>

// Rack ear modules.
// To be used either by itself if the mount-item supports it, or within another module

module rackEarStandAlone(frontThickness, sideThickness, frontWidth, sideDepth, sideHoles) {
  // TODO
}

module rackEarModule(frontThickness, sideThickness, frontWidth, sideDepth, u, triangular=true) {

  earHeight = u*uDiff + 2*rackMountScrewZDist;

  difference() {
    translate(v = [-rackMountScrewXDist, 0, -rackMountScrewZDist]) {
      cube(size = [frontWidth, frontThickness, earHeight]);

      if (triangular) {
        hull() {
          translate(v = [frontWidth-sideThickness, 0, 0])
          cube(size = [sideThickness, frontThickness, earHeight]);

          translate(v = [frontWidth-sideThickness, sideDepth, 0])
          cube(size = [sideThickness, frontThickness, 1]);
        }
      } else {
        translate(v = [frontWidth-sideThickness, 0, 0])
        cube(size = [sideThickness, sideDepth, earHeight]);
      }
    }

    union() {
      rotate(a=[90,0,0])
      cylinder(r=screwRadiusSlacked(mainRailScrewType), h=frontThickness*2, center=true);

      translate(v=[0,0,u*uDiff])
      rotate(a=[90,0,0])
      cylinder(r=screwRadiusSlacked(mainRailScrewType), h=frontThickness*2, center=true);
    }
  }
}

rackEarModule(frontThickness=3,sideThickness=3,frontWidth=30, sideDepth=50, u=4);