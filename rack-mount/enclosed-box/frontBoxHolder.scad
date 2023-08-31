include <../common.scad>
include <./helper.scad>
use <../plateBase.scad>

// To be used with closed sideRails to fully encapsulate a box

module frontBoxHolder(plateThickness=3, cutoutOffsetX, cutoutOffsetY, cutoutX, cutoutY, supportedZ, supportWidth, supportDepth=5, supportRailDefaultThickness, zOrientation) {

  //assert(supportedZ + 2*supportThickness <= boxPlateScrewToYEdge*2 + u*uDiff);
  //assert(supportWidth < rackMountScrewWidth); // not tight, need to include screw radii

  u = findU(supportedZ, supportRailDefaultThickness);
  supportRailBottomThickness = railBottomThickness(u, supportedZ, supportRailDefaultThickness, zOrientation);

  difference() {
    union() {
      plateBase(U=u, plateThickness=plateThickness, screwToXEdge=boxPlateScrewToXEdge, screwToYEdge=boxPlateScrewToYEdge, screwType=mainRailScrewType, filletR=2);

      // bottom support
      translate(v=[(rackMountScrewWidth-supportWidth)/2, -boxPlateScrewToYEdge,0])
      cube(size=[supportWidth, supportRailBottomThickness, supportDepth]);

        // top support
      translate(v=[(rackMountScrewWidth-supportWidth)/2, -boxPlateScrewToYEdge+supportRailBottomThickness+supportedZ,0])
      cube(size=[supportWidth, supportRailDefaultThickness, supportDepth]);
    }

    union() {
      translate(v=[cutoutOffsetX, cutoutOffsetY-boxPlateScrewToYEdge,-inf/2])
      minkowski() {
        r=2;
        cylinder(r=r,h=inf);
        translate(v=[r, r, 0])
        cube(size = [cutoutX-2*r, cutoutY-2*r, inf]);
      }

    }
  }

}
