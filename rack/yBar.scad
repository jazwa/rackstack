include <../helper/math.scad>
include <../misc/magnet.scad>
include <../helper/sphericalFilet.scad>
include <../helper/cylindricalFilet.scad>
include <./config.scad>
include <./screws.scad>
include <./mainRail.scad>
include <./stackConnector.scad>

// TODO clean up
// TODO: How do I nicely explain this?
railSlotSpacing = 3;
sideSpacing = 12;

yBarDepth = maxUnitDepth + 2*railSlotSpacing;
yBarWidth = railSlotSpacing + railTotalWidth + sideSpacing;
yBarHeight = 15;

yBarWallThickness = 3;
yBarRoundness = 5;

echo("Bar total depth: ", yBarDepth);
echo("Bar total width: ", yBarWidth);


module yBar() {

  module positive() {
    difference() {
      sphericalFiletEdge(yBarWidth, yBarDepth, yBarHeight, yBarRoundness);

      translate(v = [yBarWallThickness, 32, yBarWallThickness])
      cylindricalFiletEdge(yBarWidth, yBarDepth-32*2, yBarHeight, yBarRoundness);
    }
  }

  // TODO move this to custom file
  // negatives on the y-z plane to be imprinted on the side of the main
  module frontBarConnector_N() {

    y1 = 6;
    y2 = 27;
    z = 6;

    translate(v = [-m3HeatSetInsertSlotHeightSlacked, y1, z])
    rotate(a = [0, 90, 0])
    heatSetInsertSlot_N(rackFrameScrewType);

    translate(v = [-m3HeatSetInsertSlotHeightSlacked, y2, z])
    rotate(a = [0, 90, 0])
    heatSetInsertSlot_N(rackFrameScrewType);

    // TODO fix this up, no center=true
    translate(v = [-1, y1+(y2-y1)/2, 0])
    rotate(a = [0, 45, 0])
    cube(size = [3, 10, 6], center = true);
  }

  // TODO move this in custom file, like for railFeetSlot_N
  module sideWallConnector_N() {

    lugW = 7;
    lugD = 20;
    lugH = 2;

    insertDw = lugW/2;

    insertDd = lugD-4;

    translate(v = [0, 0, -lugH])
    cube(size = [lugW, lugD, lugH]);

    translate(v = [insertDw, insertDd, -(m3HeatSetInsertSlotHeightSlacked+lugH)])
    heatSetInsertSlot_N(rackFrameScrewType);
  }


  module singleCornerNoStackConnector_N() {
    union() {
      translate(v = [5, 5, 0])
      stackConnectorSocket_N();

      translate(v = [yBarWidth-(railTotalWidth+railSlotSpacing), railSlotSpacing, yBarHeight-railFootThickness])
      railFeetSlot_N();

      translate(v = [yBarWidth+eps, 0, 0])
      frontBarConnector_N();

      translate(v = [yBarWidth-(railTotalWidth+railSlotSpacing)-9, railSlotSpacing, yBarHeight])
      sideWallConnector_N();
    }
  }

  module sideBar() {

    module mirrorOtherCorner() {
      children(0);

      translate(v = [0, yBarDepth, 0])
      mirror(v = [0, 1, 0]) {
        children(0);
      }
    }

    difference() {
      positive();

      mirrorOtherCorner()
      singleCornerNoStackConnector_N();
    }
  }

  sideBar();
}
