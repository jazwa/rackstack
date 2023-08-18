include <./common.scad>
use <./attachXYTrays.scad>

$vpt = [71,123,88];
$vpr = [44,0,47];
$vpd = 450;
$vpf = 22.50;

slideHexNutsIntoYBarXYPlate(at=$t);

module slideHexNutsIntoYBarXYPlate(at=0) {

  t = lerp(a=12,b=0,t=at);

  attachXYTrays(at=1,r=0);

  slideHexNuts(t=t);

  multmatrix(upperXYTrayTrans)
    slideHexNuts(t=t);

  module plateHexNut(t) {
    multmatrix(yBarBasePlateConnectorTrans)
      translate(v=[basePlateYBarSlideNutDx+t, basePlateYBarSlideNutDy, 4 + plateBlockBaseConnRecession]) // TODO gotta rename these
        hexNut(rackFrameScrewType);
  }

  module slideHexNuts(t=0) {

    plateHexNut(t=t);

    translate(v=[xyPlateConnDx, 0,0])
    plateHexNut(t=-t);

    translate(v=[0, xyPlateConnDy,0])
    plateHexNut(t=t);

    translate(v=[xyPlateConnDx, xyPlateConnDy,0])
    plateHexNut(t=-t);
  }
}