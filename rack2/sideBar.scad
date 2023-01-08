include <../math.scad>
include <./config.scad>
include <./screws.scad>
include <./misc/magnet.scad>

include <./mainRail.scad>
include <./helper/sphericalFilet.scad>
include <./helper/cylindricalFilet.scad>

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


module sideBar() {

  module positive() {
      difference() {
        sphericalFiletEdge(barWidth, barDepth, barHeight, barRoundness);

        translate(v = [barWallThickness, 32, barWallThickness])
        cylindricalFiletEdge(barWidth, barDepth-32*2, barHeight, barRoundness);
      }

  }

  module stackConn_N() {
    taperH = 2;

    translate(v=[0,0,0])
    cube(size = [10, 10, taperH]);


    hull() {
      translate(v = [0, 0, taperH])
      linear_extrude(height=eps)
      square(size = [10, 10]);

      translate(v=[5,5,5])
      linear_extrude(height=eps)
      circle(r=magnetRSlacked);
    }

    // -1 is for male support
    translate(v=[5,5,5 - 1])
    cylinder(r=magnetRSlacked, h=magnetHSlacked);
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
    rotate(a=[0,45,0])
    cube(size=[3,10,6], center=true);
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

  module sideBar() {
    difference() {
      positive();

      singleCorner_N();

      translate(v=[0,barDepth,0])
      mirror(v=[0,1,0]) {
        singleCorner_N();
      }
    }

  }
  sideBar();
}
