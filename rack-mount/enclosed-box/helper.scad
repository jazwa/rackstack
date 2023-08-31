include <../common.scad>

// Some utility functions, as well as global functions to make code cleaner

sideRailLowerMountPointToBottom = uDiff/2;
sideRailBaseWidth = 15;
// distance between front and back main rail screw mounts
sideRailScrewMountDist = yBarDepth - 2*(frontScrewSpacing + railFrontThickness + railSlotToXZ);

boxPlateScrewToXEdge = 4.5; // wow these are named poorly
boxPlateScrewToYEdge = 5;


function findU(boxHeight, minRailThickness) = max(1, ceil((boxHeight + 2*minRailThickness)/uDiff) - 1);

function railBottomThickness(u, boxHeight, minRailThickness, zOrientation) =
  (zOrientation == "middle")
  ? (((u+1) * uDiff) - boxHeight)/2
  : (zOrientation == "bottom")
  ? minRailThickness
  : minRailThickness;