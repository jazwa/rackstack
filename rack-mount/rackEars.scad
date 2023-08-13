include <./common.scad>

// Rack ear modules.
// To be used either by itself if the item supports it, or within another module

rackEarModule(frontThickness=3,sideThickness=3,frontWidth=30, sideDepth=50, u=4, support=true);

module rackEarModule(frontThickness, sideThickness, frontWidth, sideDepth, u, backPlaneHeight=3, support=true) {

  earHeight = u*uDiff + 2*rackMountScrewZDist;

  difference() {
    translate(v = [-rackMountScrewXDist, 0, -rackMountScrewZDist]) {
      // front
      cube(size = [frontWidth, frontThickness, earHeight]);

      // side
      hull() {
        translate(v = [frontWidth-sideThickness, 0, 0])
          cube(size = [sideThickness, frontThickness, earHeight]);

        backSegmentPlane();
      }

      if (support) {
        hull() {
          extraSpacing = 1;
          translate(v= [rackMountScrewXDist+railScrewHoleToOuterEdge+extraSpacing,frontThickness,0])
            cube(size = [sideThickness, eps, earHeight]);

          backSegmentPlane();
        }
      }
    }

    rackMountHoles();
  }

  module backSegmentPlane() {
    translate(v = [frontWidth-sideThickness, sideDepth, 0])
      cube(size = [sideThickness, eps, backPlaneHeight]);
  }

  module rackMountHoles() {
    rotate(a=[90,0,0])
      cylinder(r=screwRadiusSlacked(mainRailScrewType), h=frontThickness*2, center=true);

    translate(v=[0,0,u*uDiff])
      rotate(a=[90,0,0])
        cylinder(r=screwRadiusSlacked(mainRailScrewType), h=frontThickness*2, center=true);
  }
}
