include <./config.scad>
include <./screws.scad>
include <../math.scad>

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

*mainRail();

echo("Total Rail Height: ", railTotalHeight);

module mainRail() {

  union() {
    _frontRailSegment();

    translate(v = [railSideMountThickness, railFrontThickness, 0])
    rotate(a = [0, 0, 90])
    _sideSupportSegment();

    translate(v = [0, railFrontThickness, 0]) {

      translate(v=[railSideMountThickness,0,0])
      _railFeet();

      translate(v = [railSideMountThickness, 0, railTotalHeight - railFootThickness])
      _railFeet();
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

      union() {
        for (i = [1:numRailScrews]) {
          translate(v = [frontScrewSpacing, railFrontThickness/2, i*screwDiff+railFootThickness])
          rotate(a = [90, 0, 0])
          cylinder(r = screwRadiusSlacked(mainRailSideMountScrewType), h = inf10, $fn = 32);
        }

        translate(v = [4, 0, railFootThickness + 5])
        rotate(a=[90,0,0])
        cylinder(r = screwRadiusSlacked(rackFrameScrewType), h = inf10, $fn = 32, center = true);

        translate(v = [4, 0, railTotalHeight- (railFootThickness + 5)])
        rotate(a=[90,0,0])
        cylinder(r = screwRadiusSlacked(rackFrameScrewType), h = inf10, $fn = 32, center = true);
      }
    }
  }

  module _railFeet() {
    difference() {
      cube(size = [frontFaceWidth - railSideMountThickness, sideSupportDepth, railFootThickness]);

      translate(v = [6, 4, 0])
      cylinder(r = screwRadiusSlacked(rackFrameScrewType), h = inf10, $fn = 32);

      translate(v = [6, 12, 0])
      cylinder(r = screwRadiusSlacked(rackFrameScrewType), h = inf10, $fn = 32);

    }
  }
}

module railFeetSlot_N() {

  union() {
    cube(size = [railTotalWidth, railTotalDepth, railFootThickness]);

    translate(v = [railSideMountThickness + 6, railFrontThickness + 4, -m3HeatSetInsertSlotHeightSlacked])
    heatSetInsertSlot_N(rackFrameScrewType);

    translate(v = [railSideMountThickness + 6, railFrontThickness + 12, -m3HeatSetInsertSlotHeightSlacked])
    heatSetInsertSlot_N(rackFrameScrewType);
  }
}
