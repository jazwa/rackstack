include <../../helper/common.scad>
include <../../config/common.scad>


sideWallConnW = 7;
sideWallConnD = 20;
sideWallConnH = 3;
sideWallConnLugDepression = sideWallConnH;

yBarScrewHoleToOuterYEdge = 3.5;
yBarScrewHoleToFrontXEdge = 16;

magnetFaceToSideWallConnOuterYEdge = 2;
magnetMountShellRadius = magnetRSlacked + 1;

innerSideWallToYBarMagnetConn = magnetFaceToSideWallConnOuterYEdge + sideWallSlotToOuterYEdge - sideWallThickness;

hingePoleR = dowelPinR;
hingePoleH = dowelPinH;

sideWallZHingeSlack = 0.3;
sideWallZGapClearance = 0.5;
sideWallZHingeTotalClearance = sideWallZHingeSlack + sideWallZGapClearance; // only for one edge
sideWallZ = (railTotalHeight - 2*railFootThickness) - 2*sideWallZHingeTotalClearance;
sideWallY = yBarDepth;

magnetMountToYBarTop = magnetMountShellRadius + sideWallZHingeTotalClearance + 1;
magnetMountToYBarFront = magnetMountShellRadius + sideWallSlotToXZ + 2;

sideWallXGapClearance = 0.2;
sideWallX = (yBarWidth-(railTotalWidth+railSlotToInnerYEdge)) - sideWallXGapClearance;

hingePoleDx = sideWallSlotToOuterYEdge + sideWallConnW/2.0;
hingePoleDy = sideWallY - (sideWallSlotToOuterXEdge + (hingePoleR+radiusXYSlack));

sideWallDefaultVerticalBracingToZEdge = 30;
sideWallDefaultHorizontalBracingToZEdge = sideWallDefaultVerticalBracingToZEdge;
sideWallDefaultVentilationToZEdge = 40;
sideWallDefaultVentilationToYEdge = 25;
sideWallDefaultVentilationWidth = 6;

magnetModuleMagnetMountDy = magnetMountToYBarFront - sideWallSlotToXZ;
magnetModuleMagnetMountDz = magnetMountToYBarTop + sideWallConnLugDepression;
