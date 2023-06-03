include <./config.scad>
include <../helper/screws.scad>
include <../helper/slack.scad>
include <../helper/math.scad>
include <../helper/halfspace.scad>
include <./sharedVariables.scad>
include <../helper/matrix.scad>

include <./connector/connectors.scad>

*mainRail();

module mainRail() {

  applyBevels()
  applyConnector(on="mainRail", to="yBar", trans=yBarConnectorTrans)
  applyConnector(on="mainRail", to="yBar", trans=mirrorMainRailOtherSideTrans * yBarConnectorTrans)
  mainRailBase();

  module mainRailBase() {
    union() {
      frontRailSegment();

      translate(v = [railSideMountThickness, railFrontThickness, 0])
      rotate(a = [0, 0, 90])
      sideSupportSegment();
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

  }

  yBarConnectorTrans = identity;

  module applyBevels() {
    b = 0.5; // bevel value
    apply_n() {
      union() {
        halfspace(vpos = [-1, -1, 0], p = [b, b, 0]);
        halfspace(vpos = [-1, 0, -1], p = [b, 0, b]);
        halfspace(vpos = [-1, 0, 1], p = [b, 0, railTotalHeight-b]);
      }

      children(0);
    }
  }

}

// used in assembly
mirrorMainRailOtherSideTrans = translate(v = [0, 0, railTotalHeight]) * mirror(v=[0,0,1]);

