
include <../config.scad>
include <../sharedVariables.scad>

sideWallConnW = 7;
sideWallConnD = 20;
sideWallConnH = 2;
sideWallConnLugDepression = sideWallConnH;

yBarScrewHoleToOuterYEdge = 3.5;
yBarScrewHoleToFrontXEdge = 16;

magnetFaceToSideWallConnOuterYEdge = 2;
magnetMountShellRadius = magnetRSlacked + 1;

innerSideWallToYBarMagnetConn = magnetFaceToSideWallConnOuterYEdge + sideWallSlotToOuterYEdge - sideWallThickness;

magnetMountToYBarTop = magnetMountShellRadius + 1;
magnetMountToYBarFront = magnetMountShellRadius + sideWallSlotToXZ + 2;

hingePoleR = 2;
hingePoleH = 5;
hingeHoleR = hingePoleR + 0.2;

hingePoleToConnectorOuterYZFace = hingePoleR/2;
hingePoleToConnectorOuterXZFace = hingePoleR/2;

sideWallZGapClearance = 0.2;
sideWallZ = railTotalHeight - 2*(railFootThickness + sideWallZGapClearance);

sideWallY = yBarDepth;

sideWallXGapClearance = 0.2;
sideWallX = (yBarWidth-(railTotalWidth+railSlotToInnerYEdge)) - sideWallXGapClearance;

hingePoleDx = hingePoleToConnectorOuterYZFace + sideWallSlotToOuterYEdge;
hingePoleDy = hingePoleToConnectorOuterXZFace + sideWallSlotToOuterXEdge;
