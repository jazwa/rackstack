include <../../rack/sharedVariables.scad>
include <../common.scad>
include <./helper.scad>

use <./sideRail.scad>
use <./frontBoxHolder.scad>

/*
  Enclosed box mounting system:
  Helper file to use semi-enclosed side rails and a front plate to mount a box.
  This system does not require any mounting holes on the enclosed box.

  !!! Please also make sure that the correct rack frame preset is set in rackFrame.scad !!!
*/
module enclosedBoxSystem (

// begin config ////////////////////////////////////////////////////////////////////////////////////////////////////////

// Does not affect any part dimensions. Set this to true to visualize how a box would be mounted.
visualize = false,
zOrientation = "middle", // ["middle" | "bottom"]
recessSideRail = false,

boxWidth = 160,
boxHeight = 27,
boxDepth = 120,

railDefaultThickness = 1.5,
railSideThickness = 3,

frontPlateThickness = 3,
frontPlateCutoutYSpace = 3,
frontPlateCutoutXSpace = 5,

// end config //////////////////////////////////////////////////////////////////////////////////////////////////////////

) {
  leftRailTrans = identity;
  rightRailTrans = visualize
    ? translate(v = [boxWidth, 0, 0])*mirror(v = [1, 0, 0])
    : translate(v = [sideRailBaseWidth*2, 0, 0])*mirror(v = [1, 0, 0]);

  u = findU(boxHeight, railDefaultThickness);
  railBottomThickness = railBottomThickness(u, boxHeight, railDefaultThickness, zOrientation);
  frontBoxHolderTrans = visualize
    ? translate(v = [railSideThickness-(railSupportsDx-boxWidth)/2, 0, sideRailLowerMountPointToBottom-
      railBottomThickness])*mirror(v = [0, 1, 0])*rotate(a = [90, 0, 0])
    : mirror(v = [0, 1, 0])*translate(v = [0, uDiff, frontPlateThickness-railBottomThickness]);

  if (visualize) {
    %cube(size = [boxWidth, boxDepth, boxHeight]);
  }

  multmatrix(leftRailTrans)
    sideSupportRailBase(top = true, recess = recessSideRail, defaultThickness = railDefaultThickness, supportedZ =
    boxHeight, supportedY = boxDepth, supportedX = boxWidth, zOrientation = zOrientation, railSideThickness =
    railSideThickness);

  multmatrix(rightRailTrans)
    sideSupportRailBase(top = true, recess = recessSideRail, defaultThickness = railDefaultThickness, supportedZ =
    boxHeight, supportedY = boxDepth, supportedX = boxWidth, zOrientation = zOrientation, railSideThickness =
    railSideThickness);

  multmatrix(frontBoxHolderTrans)
    frontBoxHolder(
    cutoutOffsetX = (rackMountScrewWidth-(boxWidth-2*frontPlateCutoutXSpace))/2, cutoutOffsetY = railBottomThickness+
      frontPlateCutoutYSpace,
    cutoutX = boxWidth-2*frontPlateCutoutXSpace, cutoutY = boxHeight-2*frontPlateCutoutYSpace,
    zOrientation = zOrientation, supportedZ = boxHeight, supportWidth = max(10, boxWidth-(sideRailBaseWidth+10)),
    supportRailDefaultThickness = railDefaultThickness, plateThickness = frontPlateThickness
    );
}

enclosedBoxSystem();
