include <./common.scad>
use <./slideHexNutsIntoYBar.scad>
use <./addMagnetsToMagnetModules.scad>

$vpt = [116,90,18];
$vpr = [56,0,42];
$vpd = 550;
$vpf = 22.50;

attachXBarWithYBar(at=$t);

module attachXBarWithYBar(at=0) {

  t = lerp(a=20, b=0, t=at);

  // assemble x-y bar trays
  multmatrix(translate(v = [0, 0, t]))

      if (fixedSideModules) {
          multmatrix(inv4x4(yBarToMagnetModuleTrans))
              addMagnetsToMagnetModules(at=1); // same as slideHexNutsIntoYBar, but the magnet has already been inserted
      } else {
          slideHexNutsIntoYBar(at=1);
      }
    

  multmatrix(translate(v = [0, 0, t])*xBarSpaceToYBarSpace*xBarMirrorOtherCornerTrans*yBarSpaceToXBarSpace)
      if (fixedSideModules) {
          multmatrix(inv4x4(yBarToMagnetModuleTrans))
          addMagnetsToMagnetModules(at=1);
      } else {
          slideHexNutsIntoYBar(at=1);
      }

  if (!plasticMask) {
    multmatrix(xBarSpaceToYBarSpace)
      xBar();

    multmatrix(yBarMirrorOtherCornerTrans*xBarSpaceToYBarSpace)
      xBar();
  }
}
