include <./common.scad>
use <./attachSideConnectorModulesToYBars.scad>

$vpt = [96,110,70];
$vpr = [68,0,36];
$vpd = 700;
$vpf = 22.50;

connectXYTrayWithMainRails(at=$t);

module connectXYTrayWithMainRails(at=0) {

  attachSideConnectorModulesToYBars(at=1);

  function mainRailTrans() =
    yBarMainRailConnectorTrans;

  module railAndScrew(at) {
    t1 = lerp(a=12, b=0, t=min(1, 2*at));
    t2 = lerp(a=16, b=0, t=max(0, 2*at - 1));

    if (!plasticMask) {
      translate(v=[0,0,t1])
      mainRail();
    }

    if (at >= 1/2) {
      multmatrix(
        translate(v = [mainRailSlideHexOnYBarDx, mainRailSlideHexOnYBarDy, -5])*
        rotate(a = [-45, 0, 0]))
        translate(v = [0, 0, 14 + t2]) // length of caseScrewLong
          caseScrewLong();
    }
  }

  multmatrix(mainRailTrans())
    railAndScrew(at=at);

  multmatrix(yBarMirrorOtherCornerTrans * mainRailTrans())
    railAndScrew(at=at);

  multmatrix(xBarSpaceToYBarSpace * xBarMirrorOtherCornerTrans * yBarSpaceToXBarSpace * mainRailTrans())
    railAndScrew(at=at);

  multmatrix(xBarSpaceToYBarSpace * xBarMirrorOtherCornerTrans * yBarSpaceToXBarSpace * yBarMirrorOtherCornerTrans * mainRailTrans())
    railAndScrew(at=at);
}