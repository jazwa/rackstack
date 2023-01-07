include <../math.scad>
include <./config.scad>
include <./screws.scad>
include <./mainRail.scad>
include <./helper/sphericalFilet.scad>
include <./helper/cylindricalFilet.scad>

// TODO remove support requirements
// TODO add slack to top slots
// TODO clean up
// TODO: How do I nicely explain this?
railSlotSpacing = 3;
sideSpacing = 12;

barDepth = maxUnitDepth + 2*railSlotSpacing;
barWidth = railSlotSpacing + railTotalWidth + sideSpacing;
barHeight = 15;

barWallThickness = 3;
barRoundness = 5;

echo("Bar total depth: ", barDepth);
echo("Bar total width: ", barWidth);

module connectingBar() {

  module positive() {
      difference() {
        sphericalFiletEdge(barWidth, barDepth, barHeight, barRoundness);

        translate(v = [barWallThickness, 32, barWallThickness])
        cylindricalFiletEdge(barWidth, barDepth-32*2, barHeight, barRoundness);
      }

  }

  module stackConn_N() {
    translate(v=[0,0,0])
    cube(size = [10, 10, 5]);

    translate(v=[5,5,5])
    cylinder(r=2, h=2);
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
    translate(v=[-1, y1 + (y2 - y1)/2, 0])
    cube(size=[2,10,5], center=true);
  }

  // TODO move this in custom file, like for railFeetSlot_N
  module sideWallConnector_N() {

    lugW = 7;
    lugD = 20;
    lugH = 2;

    insertDw = lugW/2;

    insertDd = lugD - 4;

    translate(v=[0,0, -lugH])
    cube(size=[lugW, lugD, lugH]);

    translate(v=[insertDw, insertDd, -(m3HeatSetInsertSlotHeightSlacked + lugH)])
    heatSetInsertSlot_N(rackFrameScrewType);
  }


  module singleCorner_N() {
    union() {
      translate(v=[5,5,0])
      stackConn_N();

      translate(v=[barWidth - (railTotalWidth + railSlotSpacing), railSlotSpacing, barHeight - railFootThickness])
      railFeetSlot_N();

      translate(v=[barWidth + eps, 0,0])
      frontBarConnector_N();


      translate(v=[barWidth - (railTotalWidth + railSlotSpacing) - 9, railSlotSpacing, barHeight])
      sideWallConnector_N();
    }
  }

  module connectingBar() {
    difference() {
      positive();

      singleCorner_N();

      translate(v=[0,barDepth,0])
      mirror(v=[0,1,0]) {
        singleCorner_N();
      }
    }

  }
  connectingBar();
}

connectingBar();
