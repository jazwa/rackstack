include <./common.scad>
use <./slideHexNutsIntoYBarXYPlate.scad>

$vpt = [96,110,70];
$vpr = [68,0,36];
$vpd = 700;
$vpf = 22.50;

attachXYPlates(at=$t);

module attachXYPlates(at=0,r=0) {

  t = lerp(a=10,b=0,t=at);

  // TODO fix xyPlate transformations
  function xyPlateToYBarTrans() = translate(v=[6,6,0]) * yBarBasePlateConnectorTrans;

  slideHexNutsIntoYBarXYPlate(at=1);

  multmatrix(xyPlateToYBarTrans())
    xyPlateWithScrews(t=t);

  multmatrix(upperXYTrayTrans * xyPlateToYBarTrans())
    xyPlateWithScrews(t=t);

  module xyPlateWithScrews(t=0) {

    module screw(t=0) {
      translate(v=[0,0,-t])
        mirror(v=[0,0,1])
          caseScrewMedium();
    }

    if (!plasticMask) {
      translate(v = [0, 0, -t])
        xyPlate();
    }

    screw(t=2*t);

    translate(v=[xyPlateConnDx, 0,0])
      screw(t=2*t);

    translate(v=[0, xyPlateConnDy,0])
      screw(t=2*t);

    translate(v=[xyPlateConnDx, xyPlateConnDy,0])
      screw(t=2*t);
  }
}