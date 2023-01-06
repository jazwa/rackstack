include <../math.scad>
include <./config.scad>
include <./screws.scad>
include <./mainRail.scad>
include <./helper/sphericalFilet.scad>
include <./helper/cylindricalFilet.scad>

// TODO: How do I nicely explain this?
railSlotSpacing = 2;
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

  // negatives on the y-z plane to be imprinted on the side of the main
  module sideConnector_N() {

    zOffset = 7.5;
    y1 = 5;
    y2 = 27;

    translate(v=[ - m3HeatSetInsertSlotHeightSlacked, y1, zOffset])
    rotate(a=[0,90,0])
    heatSetInsertSlot_N(rackFrameScrewType);

    translate(v=[ - m3HeatSetInsertSlotHeightSlacked, y2, zOffset])
    rotate(a=[0,90,0])
    heatSetInsertSlot_N(rackFrameScrewType);

    translate(v=[-1, y1 + (y2 - y1)/2, zOffset])
    cube(size=[2,10,5], center=true);
  }

  module railConnector_N() {

  }

  module test() {
    difference() {
      positive();

      union() {
        translate(v=[5,5,0])
        stackConn_N();

        translate(v=[barWidth - (railTotalWidth + railSlotSpacing), railSlotSpacing, barHeight - railFootThickness])
        railFeetSlot_N();

        translate(v=[barWidth + eps, 0,0])
        sideConnector_N();

        // TODO change this
        translate(v=[barWidth - (railTotalWidth + railSlotSpacing) - 7, railSlotSpacing, barHeight-2])
        cube(size=[5,13,2]);
      }
    }

  }
  test();
}

connectingBar();
*intersection() {
  connectingBar();

  cube(size=[21,100,100]);
}
