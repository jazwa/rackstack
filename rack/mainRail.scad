include <./config.scad>
include <../helper/screws.scad>
include <../helper/math.scad>
include <../helper/halfspace.scad>

/* Small horizontal planes at the top and bottom of the main rails. Used so we can fasten the rail to the frame
   Note that this value is also used for a depression at the bottom/top of the frame for aligning the rail */
railFootThickness = 3;

railTotalHeight = screwDiff * (numRailScrews + 1) + 2 * railFootThickness;

railFrontThickness = 6; // Make sure that the nuts for the chosen screw type can slot within the front face
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

mainRail();

echo("Total Rail Height: ", railTotalHeight);

// Also known as the z-bar :)
module mainRail() {

  mainRail();

  module mainRail() {
    b = 0.75; // bevel value
    intersection() {
      mainRailSharp();
      halfspace(vpos=[1,1,0], p=[b,b,0]);
      halfspace(vpos=[1,0,1], p=[b,0,b]);
      halfspace(vpos=[1,0,-1], p=[b,0,railTotalHeight-b]);

    }
  }


  module mainRailSharp() {
    union() {
      _frontRailSegment();

      translate(v = [railSideMountThickness, railFrontThickness, 0])
      rotate(a = [0, 0, 90])
      _sideSupportSegment();

      translate(v = [0, railFrontThickness, 0]) {

        translate(v = [railSideMountThickness, 0, 0])
        _railFeet();

        translate(v = [railSideMountThickness, 0, railTotalHeight-railFootThickness])
        _railFeet();
      }
    }
  }

  module _frontRailSegment() {
    difference() {
      cube(size = [frontFaceWidth, railFrontThickness, railTotalHeight]);

      for (i = [1:numRailScrews]) {
        translate(v = [railScrewHoleToOuterEdge, railFrontThickness / 2, i * screwDiff + railFootThickness])
        rotate(a = [90, 0, 0])
        hexNutPocket_N(mainRailScrewType);
      }
    }
  }

  module _sideSupportSegment() {
    difference() {
      cube(size = [sideSupportDepth, railSideMountThickness, railTotalHeight]);
      
      for (i = [1:numRailScrews]) {
        translate(v = [frontScrewSpacing, railFrontThickness/2, i*screwDiff+railFootThickness])
        rotate(a = [90, 0, 0])
        cylinder(r = screwRadiusSlacked(mainRailSideMountScrewType), h = inf10, $fn = 32);
      }
    }
  }

  module _railFeet() {
    difference() {
      cube(size = [frontFaceWidth - railSideMountThickness, sideSupportDepth, railFootThickness]);

      translate(v = [5, 4, 0])
      cylinder(r = screwRadiusSlacked(rackFrameScrewType), h = inf10, $fn = 32);
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
