include <../helper/common.scad>
include <../config/common.scad>
include <./sharedVariables.scad>
include <./connector/connectors.scad>

mainRail();

module mainRail() {

  applyBevels()
  applyConnector(on="mainRail", to="yBar", trans=yBarConnectorTrans)
  applyConnector(on="mainRail", to="yBar", trans=mirrorMainRailOtherSideTrans * yBarConnectorTrans)
  mainRailBase();

  module mainRailBase() {

    difference() {
      union() {
        frontRailSegment();

        translate(v = [railSideMountThickness, railFrontThickness, 0])
        rotate(a = [0, 0, 90])
        sideSupportSegment();
      }
    }

    module frontRailSegment() {
      difference() {
        cube(size = [frontFaceWidth, railFrontThickness, railTotalHeight]);

        for (i = [1:numRailScrews]) {
          translate(v = [railScrewHoleToOuterEdge, railFrontThickness/2, i*screwDiff+railFootThickness])
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

        cylindricalFiletNegative(p0=[frontFaceWidth, 0, 0], p1=[frontFaceWidth, 0, railTotalHeight], n=[1,-1,0], r=1);
        cylindricalFiletNegative(p0=[frontFaceWidth, railFrontThickness, railFootThickness+4], p1=[frontFaceWidth, railFrontThickness, railTotalHeight-(railFootThickness+4)], n=[1,1,0], r=1);
      }

      children(0);
    }
  }
}
