
include <../config.scad>
include <../sharedVariables.scad>
include <../../misc/magnet.scad>

sideWallConnW = 7;
sideWallConnD = 20;
sideWallConnH = 2;
sideWallConnLugDepression = sideWallConnH;

yBarScrewHoleToOuterYEdge = 3.5;
yBarScrewHoleToFrontXEdge = 16;

magnetFaceToSideWallConnOuterYEdge = 2;
magnetMountShellRadius = magnetRSlacked + 1;

innerSideWallToYBarMagnetConn = magnetFaceToSideWallConnOuterYEdge + sideWallSlotToOuterYEdge - sideWallThickness;

hingePoleR = 2;
hingePoleH = 5;
hingeHoleR = hingePoleR + 0.2;


sideWallZHingeSlack = 0.3;
sideWallZGapClearance = 1.0;
sideWallZHingeTotalClearance = sideWallZHingeSlack + sideWallZGapClearance;
sideWallZ = (railTotalHeight - 2*railFootThickness) - 2*sideWallZHingeTotalClearance;
sideWallY = yBarDepth;

magnetMountToYBarTop = magnetMountShellRadius + sideWallZHingeTotalClearance + 1;
magnetMountToYBarFront = magnetMountShellRadius + sideWallSlotToXZ + 2;

sideWallXGapClearance = 0.2;
sideWallX = (yBarWidth-(railTotalWidth+railSlotToInnerYEdge)) - sideWallXGapClearance;

hingePoleDx = sideWallSlotToOuterYEdge + sideWallConnW/2.0;
hingePoleDy = sideWallY - (sideWallSlotToOuterXEdge + hingeHoleR);
