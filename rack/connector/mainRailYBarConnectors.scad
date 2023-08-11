include <../../helper/common.scad>
include <../../config/common.scad>
include <../sharedVariables.scad>

mainRailSlideHexOnYBarDx = railSideMountThickness + 5;
mainRailSlideHexOnYBarDy = railFrontThickness + 2;

module onYBarToMainRailNegative() {

  slotSlack = xySlack;
  slotZSlack = zSlack;

  union() {
    translate(v=[-slotZSlack/2, -slotSlack/2,0])
    cube(size = [railTotalWidth+slotZSlack, railTotalDepth + slotSlack, railFootThickness]);

    translate(v = [mainRailSlideHexOnYBarDx, mainRailSlideHexOnYBarDy, -5])
    rotate(a=[-45,0,0])
    hexNutPocket_N("m3", openSide=false, backSpace=5);
  }
}

module onMainRailYBarConnectorPositive() {
  cube(size = [frontFaceWidth, sideSupportDepth+railFrontThickness, railFootThickness]);

  // TODO magic numbers
  hull() {
    cube(size = [frontFaceWidth, railFrontThickness+8, railFootThickness+4]);
    translate(v = [0, railFrontThickness+14, 0])
    cube(size = [frontFaceWidth, 1, railFootThickness]);
  }
}


module onMainRailYBarConnectorNegative() {

screwOffset = 9;

  translate(v = [mainRailSlideHexOnYBarDx, mainRailSlideHexOnYBarDy + screwOffset, -5 + screwOffset])
  rotate(a=[-45,0,0])
  counterSunkHead_N(rackFrameScrewType, screwExtension=inf50, headExtension=inf50);

}
