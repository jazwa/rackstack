include <./config.scad>
include <../helper/screws.scad>
include <../helper/math.scad>
include <../helper/halfspace.scad>
include <./sharedVariables.scad>

*mainRail();

// Also known as the z-bar :)
module mainRail() {

    b = 0.75; // bevel value
    intersection() {
      mainRailSharp();
      halfspace(vpos=[1,1,0], p=[b,b,0]);
      halfspace(vpos=[1,0,1], p=[b,0,b]);
      halfspace(vpos=[1,0,-1], p=[b,0,railTotalHeight-b]);
    }

  module mainRailSharp() {
    union() {
      frontRailSegment();

      translate(v = [railSideMountThickness, railFrontThickness, 0])
      rotate(a = [0, 0, 90])
      sideSupportSegment();

      translate(v = [0, railFrontThickness, 0]) {
        translate(v = [railSideMountThickness, 0, 0])
        railFeet();
        translate(v = [railSideMountThickness, 0, railTotalHeight])
        mirror(v=[0,0,1])
        railFeet();
      }
    }
  }

  module frontRailSegment() {
    difference() {
      cube(size = [frontFaceWidth, railFrontThickness, railTotalHeight]);

      for (i = [1:numRailScrews]) {
        translate(v = [railScrewHoleToOuterEdge, railFrontThickness / 2, i * screwDiff + railFootThickness])
        rotate(a = [90, 0, 0])
        hexNutPocket_N(mainRailScrewType);
      }
    }
  }

  module sideSupportSegment() {
    difference() {
      cube(size = [sideSupportDepth, railSideMountThickness, railTotalHeight]);
      
      for (i = [1:numRailScrews]) {
        translate(v = [frontScrewSpacing, railFrontThickness/2, i*screwDiff+railFootThickness])
        rotate(a = [90, 0, 0])
        cylinder(r = screwRadiusSlacked(mainRailSideMountScrewType), h = inf10, $fn = 32);
      }
    }
  }

  module railFeet() {
    difference() {
      cube(size = [frontFaceWidth - railSideMountThickness, sideSupportDepth, railFootThickness]);

      translate(v = [5, 4, railFootThickness])
      counterSunkHead_N(rackFrameScrewType, screwExtension=inf10, headExtension=inf10);
    }
  }
}

module railFeetSlot_N() {

  slotSlack = 0.2;
  union() {
    translate(v=[-slotSlack/2, -slotSlack/2,0])
    cube(size = [railTotalWidth + slotSlack, railTotalDepth + slotSlack, railFootThickness]);

    translate(v = [railSideMountThickness + 5, railFrontThickness + 4 , -m3HeatSetInsertSlotHeightSlacked])
    heatSetInsertSlot_N(rackFrameScrewType);
  }
}
