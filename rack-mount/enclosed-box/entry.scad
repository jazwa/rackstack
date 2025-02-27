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

/* [Visualization] */
// Show box preview
visualize = false;
// Vertical position of the box
zOrientation = "middle"; // [middle,bottom]
// Recess the side rails
recessSideRail = false;

/* [Box Dimensions] */
// Width of the box in mm
boxWidth = 160; // [100:1:300]
// Height of the box in mm
boxHeight = 27; // [20:1:100]
// Depth of the box in mm
boxDepth = 120; // [80:1:250]

/* [Rail Settings] */
// Default thickness of the rails
railDefaultThickness = 1.5; // [1:0.5:5]
// Thickness of rail sides
railSideThickness = 3; // [2:0.5:6]

/* [Front Plate Settings] */
// Thickness of the front plate
frontPlateThickness = 3; // [2:0.5:6]
// Vertical space between box and cutout
frontPlateCutoutYSpace = 3; // [1:0.5:10]
// Horizontal space between box and cutout
frontPlateCutoutXSpace = 5; // [1:0.5:15]

module enclosedBoxSystem (
  visualize = visualize,
  zOrientation = zOrientation,
  recessSideRail = recessSideRail,
  boxWidth = boxWidth,
  boxHeight = boxHeight,
  boxDepth = boxDepth,
  railDefaultThickness = railDefaultThickness,
  railSideThickness = railSideThickness,
  frontPlateThickness = frontPlateThickness,
  frontPlateCutoutYSpace = frontPlateCutoutYSpace,
  frontPlateCutoutXSpace = frontPlateCutoutXSpace
) {
  // Rest of your code remains the same
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
