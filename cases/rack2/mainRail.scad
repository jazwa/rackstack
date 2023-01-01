include <./config.scad>
include <./screws.scad>

/* Small horizontal planes at the top and bottom of the main rails. Used so we can fasten the rail to the frame
   Note that this value is also used for a depression at the bottom/top of the frame for aligning the rail */
railFootThickness = 3;

railTotalHeight = screwDiff * (numRailScrews + 1) + 2 * railFootThickness;

mainRail();
echo("Total Rail Height = ", railTotalHeight);

module mainRail() {

  // Distance between the middle of a screw mount and the rail's vertical edges

  railScrewHoleToInnerEdge = 5;
  railScrewHoleToOuterEdge = 5;

  // Distance between the midpoint of the rail screw holes.
  rackMountScrewWidth = maxUnitWidth + 2 * railScrewHoleToInnerEdge;

  railFrontThickness = 6; // Make sure that the nuts for the chosen screw type can slot within the front face
  railSideMountThickness = 2.5;
  railOtherThickness = 2.5;


  // Extra spacing for the rack unit screws.
  frontScrewSpacing = 8;

  sideSupportExtraSpace = 2;
  sideSupportScrewHoleToFrontEdge = 5;
  sideSupportScrewHoleToBackEdge = 4.5;
  sideSupportDepth = sideSupportScrewHoleToBackEdge + sideSupportScrewHoleToFrontEdge;

  frontFaceWidth = railScrewHoleToInnerEdge + railScrewHoleToOuterEdge;

  union() {
    _frontRailSegment();

    translate(v = [0, railFrontThickness, 0])
    _connectingLBracketRailSegment();

    translate(v = [frontFaceWidth - sideSupportExtraSpace, railFrontThickness + railOtherThickness + frontScrewSpacing,
      0])
    rotate(a = [0, 0, 90])
    _sideSupportSegment();


    translate(v = [0, railFrontThickness + railOtherThickness + frontScrewSpacing, 0]) {
      _railFeet();

      translate(v = [0, 0, railTotalHeight - railFootThickness])
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

  module _connectingLBracketRailSegment() {

    difference() {
      cube(size = [railOtherThickness, frontScrewSpacing + railOtherThickness, railTotalHeight]);

      union() {
        translate(v = [0, 4, railFootThickness + screwDiff / 2])
        rotate(a = [0, 90, 0])
        cylinder(r = screwRadiusSlacked(rackFrameScrewType), h = 10, $fn = 32, center = true);

        translate(v = [0, 4, railTotalHeight - (railFootThickness + screwDiff / 2)])
        rotate(a = [0, 90, 0])
        cylinder(r = screwRadiusSlacked(rackFrameScrewType), h = 10, $fn = 32, center = true);
      }
    }

    translate(v = [0, frontScrewSpacing + railOtherThickness, 0])
    rotate(a = [0, 0, 270])
    cube(size = [railOtherThickness, frontFaceWidth - sideSupportExtraSpace, railTotalHeight]);
  }


  module _sideSupportSegment() {

    difference() {
      cube(size = [sideSupportDepth, railSideMountThickness, railTotalHeight]);

      for (i = [1:numRailScrews]) {
        translate(v = [sideSupportScrewHoleToFrontEdge, railFrontThickness / 2, i * screwDiff + railFootThickness])
        rotate(a = [90, 0, 0])
        cylinder(r = screwRadiusSlacked(mainRailSideMountScrewType), h = 10, $fn = 32);
      }
    }

  }

  module _railFeet() {

    difference() {
      cube(size = [frontFaceWidth - sideSupportExtraSpace, sideSupportDepth, railFootThickness]);

      hull() {
        translate(v = [1.5, 5, 0])
        cylinder(r = screwRadiusSlacked(rackFrameScrewType), h = 10, $fn = 32);

        translate(v = [0, 5, 0])
        cube(size = [0.1, screwRadiusSlacked(rackFrameScrewType) * 2, 10], center = true);
      }
    }
  }

}
