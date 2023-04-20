/*
  Connector factory
*/
include <../helper/screws.scad>
include <../helper/slack.scad>
include <../helper/dovetail.scad>
include <../helper/halfspace.scad>
include <./config.scad>

// WIP

partList = ["yBar", "xBar", "mainRail", "xyPlate", "sideModule"];

// Default is to apply the positive first
module applyConnector(on,to) {

}

module connectorPositive(on, to) {

  if (on == "yBar" && to == "xBar") {
    onYBarToXBarPositive();
  }


  module onYBarToXBarPositive() {
    rotate(a=[0,0,-90])
    dovetail(
    topWidth = 15,
    bottomWidth = 12,
    height = 2,
    length = yBarHeight,
    headExtension = 1,
    baseExtension = 2,
    frontFaceLength = 2,
    frontFaceScale = 0.95,
    backFaceLength = 5,
    backFaceScale = 1.2);
  }

}

module connectorNegative(on, to) {

  if (on == "yBar" && to == "xBar") {
    onYBarToXBarNegative();
  } else if (on == "xBar" && to == "yBar") {
    onXBarToYBarNegative();
  } else if (on == "yBar" && to == "sideModule") {
    onYBarSideModuleNegative();
  }


  module onYBarToXBarNegative() {
    y = 27;
    z = 6;
    translate(v = [-m3HeatSetInsertSlotHeightSlacked, y, z])
    rotate(a = [0, 90, 0])
    heatSetInsertSlot_N(rackFrameScrewType);

  }

  module onXBarToYBarNegative() {
    y = 27;
    z = 6;
    slack = xySlack;

    translate(v=[-0.5,14,0])
    mirror(v=[1,0,0])
    rotate(a=[0,0,-90])
    dovetail(topWidth = 15+slack, bottomWidth = 12+slack, height = 2+slack, length = yBarHeight,
             headExtension = 1, baseExtension = 2, frontFaceLength = 0.5, frontFaceScale = 1.05,
             backFaceLength = 5, backFaceScale = 1.2);

    // TODO clean this up
    translate(v = [-6, y, z])
    rotate(a = [0, -90, 0])
    counterSunkHead_N(rackFrameScrewType, screwExtension=inf10, headExtension=inf10);
  }

  module onYBarSideModuleNegative() {
    translate(v = [-xySlack/2, -xySlack/2, -sideWallConnLugDepression])
    cube(size = [sideWallConnW+xySlack, sideWallConnD+xySlack, sideWallConnLugDepression]);

    translate(v = [yBarScrewHoleToOuterYEdge, yBarScrewHoleToFrontXEdge, -(m3HeatSetInsertSlotHeightSlacked+sideWallConnLugDepression)])
    heatSetInsertSlot_N(rackFrameScrewType);
  }


}

