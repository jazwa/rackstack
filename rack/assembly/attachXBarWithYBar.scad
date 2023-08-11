include <./common.scad>
use <./slideHexNutsIntoYBar.scad>

$vpt = [116,90,18];
$vpr = [56,0,42];
$vpd = 550;
$vpf = 22.50;

attachXBarWithYBar(at=$t);

module attachXBarWithYBar(at=0) {

  t = lerp(a=20, b=0, t=at);

  // assemble x-y bar trays
  multmatrix(translate(v = [0, 0, t]))
    slideHexNutsIntoYBar(at=1);

  multmatrix(translate(v = [0, 0, t])*xBarSpaceToYBarSpace*xBarMirrorOtherCornerTrans*yBarSpaceToXBarSpace)
    slideHexNutsIntoYBar(at=1);

  if (!plasticMask) {
    multmatrix(xBarSpaceToYBarSpace)
      xBar();

    multmatrix(yBarMirrorOtherCornerTrans*xBarSpaceToYBarSpace)
      xBar();
  }
}
