include <../math.scad>
include <./config.scad>
include <./screws.scad>
include <./mainRail.scad>
include <./helper/sphericalFilet.scad>
include <./helper/cylindricalFilet.scad>

railSlotSpacing = 4;
sideSpacing = 12;

barDepth = maxUnitDepth + 2*railSlotSpacing;
barWidth = railSlotSpacing + railTotalWidth + sideSpacing;
barHeight = 15;

barWallThickness = 3;
barRoundness = 12;

echo("Bar total depth: ", barDepth);
echo("Bar total width: ", barWidth);

module connectingBar() {

  module _positive() {
    minkowski() {
      difference() {
        sphericalFiletEdge(barWidth, barDepth, barHeight, barRoundness);

        translate(v = [barWallThickness, 40, barWallThickness])
        cylindricalFiletEdge(barWidth, barDepth-80, barHeight, barRoundness);
      }
    }
  }


  module _stackConn() {
    translate(v=[0,0,0])
    cube(size = [10, 10, 5]);

    translate(v=[5,5,5])
    cylinder(r=2, h=2);
  }

  module _sideConnector() {
    //translate(v=[1.5, railTotalDepth - 4, -m3HeatSetInsertSlotHeightSlacked])
    rotate(a=[0,90,0])
    heatSetInsertSlot_N(rackFrameScrewType);
  }

  module _test() {
    difference() {
      _positive();

      union() {
        translate(v=[10,10,0])
        _stackConn();

        translate(v=[barWidth - (railTotalWidth + railSlotSpacing), railSlotSpacing, barHeight - railFootThickness])
        railFeetSlot_N();

        translate(v=[barWidth - m3HeatSetInsertSlotHeightSlacked + eps, 6, 7.5])
        _sideConnector();

        translate(v=[barWidth - m3HeatSetInsertSlotHeightSlacked + eps, 35, 7.5])
        _sideConnector();
      }
    }

  }
  _test();

  translate(v=[barWidth - m3HeatSetInsertSlotHeightSlacked + eps, 6, 7.5])
  _sideConnector();

}

connectingBar();


intersection() {
  connectingBar();

  cube(size=[15,100,100]);
}
