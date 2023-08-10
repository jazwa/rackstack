// To be used with closed sideRails to fully encapsulate a box

include <../config/common.scad>
include <../helper/common.scad>
include <./common.scad>
use <./plateBase.scad>


frontBoxHolder(u=2, plateThickness=3, cutoutOffsetX=20, cutoutOffsetY=2, cutoutX=147, cutoutY=26,
    support=true, supportedZ = 27.5, supportWidth=120, supportDepth=5, supportRailBaseThickness=1.25);


module frontBoxHolder(u, plateThickness=3, cutoutOffsetX, cutoutOffsetY, cutoutX, cutoutY, support=false, supportedZ, supportWidth, supportDepth, bottomSupportThickness = 2, supportRailBaseThickness = 2) {

  plateScrewToXEdge = 4.5; // wow these are named poorly
  plateScrewToYEdge = 5;

  if (support) {
    //assert(supportedZ + 2*supportThickness <= plateScrewToYEdge*2 + u*uDiff);
    //assert(supportWidth < rackMountScrewWidth); // not tight, need to include screw radii
  }

  difference() {
    union() {
      plateBase(U=u, plateThickness=plateThickness, screwToXEdge=plateScrewToXEdge, screwToYEdge=plateScrewToYEdge, screwType=mainRailScrewType, filletR=2);

      if (support) {

        bottomSuportThickness = supportRailBaseThickness;

        translate(v=[(rackMountScrewWidth-supportWidth)/2, -plateScrewToYEdge,0])
        cube(size=[supportWidth, bottomSuportThickness, supportDepth]);

        translate(v=[(rackMountScrewWidth-supportWidth)/2, (-plateScrewToYEdge+bottomSuportThickness) + supportedZ,0])
        cube(size=[supportWidth, bottomSuportThickness, supportDepth]);
      }
    }

    union() {
      translate(v=[cutoutOffsetX, cutoutOffsetY-plateScrewToYEdge,-inf/2])
      minkowski() {
        r=2;
        cylinder(r=r,h=inf);
        translate(v=[r, r, 0])
        cube(size = [cutoutX-2*r, cutoutY-2*r, inf]);
      }

    }
  }





}
