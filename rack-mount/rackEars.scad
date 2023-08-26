include <./common.scad>

// Rack ear modules.
// To be used either by itself if the item supports it, or within another module

rackEarModule(u=4, frontThickness=3, sideThickness=3, frontWidth=20, sideDepth=50, backPlaneHeight, support=true);

module rackEarModule(
  u,
  frontThickness,
  sideThickness,
  frontWidth,
  sideDepth,
  backPlaneHeight,
  support=true
) {

  // check frontWidth is wide enough
  assert(frontWidth-sideThickness >= rackMountScrewXDist+railScrewHoleToInnerEdge);

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
        defaultExtraSpacing = 1;
        extraSpacing = frontWidth-(rackMountScrewXDist+railScrewHoleToInnerEdge+sideThickness) > defaultExtraSpacing
          ? defaultExtraSpacing
          : 0; // don't include extra spacing for support, if tray itself is too large

        hull() {
          translate(v= [rackMountScrewXDist+railScrewHoleToInnerEdge+extraSpacing,frontThickness,0])
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
      cylinder(r=screwRadiusSlacked(mainRailScrewType), h=inf, center=true);

    translate(v=[0,0,u*uDiff])
      rotate(a=[90,0,0])
        cylinder(r=screwRadiusSlacked(mainRailScrewType), h=inf, center=true);
  }
}
