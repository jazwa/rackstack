include <../config/common.scad>

// TODO: This rather unweildy config file is the result of multiple lazy and forgetful refactors. Clean it up.

// Main rail variables:

/* Small horizontal planes at the top and bottom of the main rails. Used so we can fasten the rail to the frame
   Note that this value is also used for a depression at the bottom/top of the frame for aligning the rail */
railFootThickness = 3;

railTotalHeight = screwDiff * (numRailScrews + 1) + 2 * railFootThickness;

railFrontThickness = 8; // Make sure that the nuts for the chosen screw type can slot within the front face
railSideMountThickness = 2.5;

// Distance between the middle of a screw mount and the rail's vertical edges
railScrewHoleToInnerEdge = 5;
railScrewHoleToOuterEdge = 7;

// Distance between the midpoint of the rail screw holes.
rackMountScrewWidth = maxUnitWidth + 2 * railScrewHoleToInnerEdge;

// Extra spacing for screws.
frontScrewSpacing = 15;

sideSupportScrewHoleToBackEdge = 4;
sideSupportDepth = sideSupportScrewHoleToBackEdge + frontScrewSpacing;

frontFaceWidth = railScrewHoleToInnerEdge + railScrewHoleToOuterEdge;

railTotalWidth = frontFaceWidth;
railTotalDepth = railFrontThickness+sideSupportDepth;

// Side Wall variables, cannot put in sideWallVariables due to dependency by ybar
sideWallThickness = 2.5;

sideWallSlotToOuterYEdge = 3;
sideWallSlotToOuterXEdge = 3; // TODO rename to variables found in ybar
sideWallConnectorSlotWidth = 7;

// Y Bar variables:
railSlotToXZ = 3;
sideWallSlotToXZ = 3;

railSlotToInnerYEdge = 2;
railSlotToSideWallSlot = 2;

yBarWidth = railSlotToInnerYEdge + railTotalWidth+ railSlotToSideWallSlot
  + sideWallSlotToOuterYEdge + sideWallConnectorSlotWidth;
yBarDepth = maxUnitDepth + 2*railSlotToInnerYEdge;
yBarHeight = 15;
yBarWallThickness = 3;
yBarRoundness = baseRoundness;

joinCornerDepth = 32;

// It's actually the railSlotToInnerYEdge of the yBar, it'll be nice to be able to refer to it like yBar.railSlotToInnerYEdge
xBarX = maxUnitWidth - 2*railSlotToInnerYEdge;
xBarY = 32;
xBarHeight = 15;

xBarWallThickness = 3;
xBarSideThickness = 8;
xBarRoundness = baseRoundness;

rackTotalWidth = 2*yBarWidth + xBarX;
rackTotalDepth = yBarDepth;


// Dimensions for the connector block, applied to y-bar
yBarXYPlateBlockX = 12;
yBarXYPlateBlockY = 14;
yBarXYPlateBlockZ = 10;

// Needed for y bar to align this connector to its inner Y edge
yBarBasePlateConnectorWidth = yBarXYPlateBlockX;

// x and y faces of the yBarBasePlateMount_P block
plateBlockInnerXFaceToScrew = 6;
plateBlockInnerYFaceToScrew = 8;
plateBlockBaseConnRecession = 3;
plateBlockBaseConnY = 8;

basePlateYBarSlideNutDx = yBarXYPlateBlockX - plateBlockInnerXFaceToScrew;
basePlateYBarSlideNutDy = yBarXYPlateBlockY - plateBlockInnerYFaceToScrew;

basePlateScrewMountToYBarXZFace = basePlateYBarSlideNutDy + joinCornerDepth; // Distance to the nearest YBar XZ face
basePlateScrewMountToYBarYZFace =  (yBarWidth+basePlateYBarSlideNutDx) - yBarBasePlateConnectorWidth;

basePlateConnYBarCornerDx = yBarWidth; // distance from a plate body corner and the nearest yBar corner
basePlateConnYBarCornerDy = xBarY; // distance from a plate body corner and the nearest yBar corner

basePlateConnPosX = basePlateScrewMountToYBarYZFace - basePlateConnYBarCornerDx; // distance between plateBody corner at (0,0,0) and the related corner
basePlateConnPosY = basePlateScrewMountToYBarXZFace - basePlateConnYBarCornerDy;

xyPlateConnDx = xBarX + 2*basePlateYBarSlideNutDx; // X distance between connectors
xyPlateConnDy = yBarDepth - 2*basePlateScrewMountToYBarXZFace; // Y distance between connectors
plateGap = 1; // distance between edge of xy plate and other parts
assert(plateGap >= xySlack);


connectorYEdgeToYBarYEdge = 5;
connectorXEdgeToYBarXEdge = 5;

connectorRectWidth = 10;
connectorRectDepth = 10;
connectorTotalHeight = 10;

connectorSocketMagnetExtrudeHeight = 1;
connectorTaperStartHeight = 3;
connectorTopR = 3;
connectorRectPlugSlack = -0.2;
connectorRectSocketSlack = 0.2;
connectorBottomToScrew = 6;
// Distance from midpoint of stack connectors to each other
stackConnectorDx = rackTotalWidth - 2*(connectorXEdgeToYBarXEdge + connectorRectWidth/2);
stackConnectorDy = rackTotalDepth - 2*(connectorYEdgeToYBarYEdge + connectorRectDepth/2);
stackConnectorDualSpacing = 0.5;

feetProtrusionAngle = 40;