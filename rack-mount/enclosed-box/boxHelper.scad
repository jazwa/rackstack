include <../../rack/sharedVariables.scad>
include <../common.scad>

use <../sideRail.scad>
use <../frontBoxHolder.scad>

/*
  (WIP) Enclosed box mounting system:
  Helper file to use semi-enclosed side rails and a front plate to mount a box.
  This system does not require any mounting holes for the enclosed box.

  !!! Please also make sure that the correct rack frame preset is set in rackFrame.scad !!!
*/

// begin config ////////////////////////////////////////////////////////////////////////////////////////////////////////

boxWidth = 160;
boxHeight = 27;
boxDepth = 100;


railDefaultThickness = 1.2;

zOrientation = "middle";

// Does not affect any part dimensions. Set this to true to visualize how a box wound be mounted.
visualize = true;

// end config //////////////////////////////////////////////////////////////////////////////////////////////////////////

#cube(size=[boxWidth, boxDepth, boxHeight]);

sideSupportRailBase(top=true, defaultThickness=railDefaultThickness, supportedZ=boxHeight, supportedY=boxDepth, supportedX=boxWidth, zOrientation=zOrientation);

translate(v=[boxWidth,0,0])
mirror(v=[1,0,0])
sideSupportRailBase(top=true, defaultThickness=railDefaultThickness, supportedZ=boxHeight, supportedY=boxDepth, supportedX=boxWidth, zOrientation=zOrientation);

translate(v=[0,0,10])
rotate(a=[-90,0,0])
*frontBoxHolder(
u=2,
plateThickness=3,
cutoutOffsetX=(rackMountScrewWidth-147)/2,
cutoutOffsetY=4.25,
cutoutX=147,
cutoutY=21.5,
support=true,
supportedZ=boxHeight,
supportWidth=120,
supportDepth=5,
supportRailBaseThickness=1.75
);
