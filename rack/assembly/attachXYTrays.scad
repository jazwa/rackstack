include <./common.scad>
use <./attachSideConnectorModulesToYBars.scad>
use <./propUpBottomXYTraywithSideWalls.scad>

$vpt = [71,123,88];
$vpr = [44,0,47];
$vpd = 450;
$vpf = 22.50;

attachXYTrays(at=$t);

module attachXYTrays(at=0,r=0) {

  t1 = lerp(a=12, b=0, t=min(1, 2*at));
  t2 = lerp(a=16, b=0, t=max(0, 2*at - 1));

  module singleScrew() {
    translate(v = [mainRailSlideHexOnYBarDx, mainRailSlideHexOnYBarDy, -5])
      rotate(a=[-45,0,0])
        translate(v=[0,0,14 + t2]) // length of caseScrewB
      caseScrewA();
  }

  translate(v=[0,0,t1])
    multmatrix(upperXYTrayTrans) {
      attachSideConnectorModulesToYBars(at=1);

      if (at >= 1/2) {
        mirrorAllTrayCornersFromYBarSpace()
        multmatrix(yBarMainRailConnectorTrans)
          singleScrew();
      }
    }

  propUpBottomXYTraywithSideWalls(at=1,r=r);
}